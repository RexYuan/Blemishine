
# convert PSD to flattened PNG (lossless, max compression)
# usage: psd-to-png <file.psd>
function psd-to-png
{
    if [[ ! $# -eq 1 ]]; then
        echo "usage: psd-to-png <file.psd>"
        return 1
    fi

    magick "$1[0]" \
        -alpha on \
        -define png:compression-level=9 \
        -define png:compression-filter=5 \
        -define png:compression-strategy=1 \
        "${1%.psd}.png"
}

# convert PSD to flattened TIFF (lossless ZIP compression)
# usage: psd-to-tiff <file.psd>
function psd-to-tiff
{
    if [[ ! $# -eq 1 ]]; then
        echo "usage: psd-to-tiff <file.psd>"
        return 1
    fi

    magick "$1[0]" \
        -alpha on \
        -define tiff:compression=zip \
        "${1%.psd}.tiff"
}

# convert PSD to JPEG (best possible quality, minimum loss)
# usage: psd-to-jpg <file.psd>
function psd-to-jpg
{
    if [[ ! $# -eq 1 ]]; then
        echo "usage: psd-to-jpg <file.psd>"
        return 1
    fi

    magick "$1[0]" \
        -alpha off \
        -colorspace sRGB \
        -quality 100 \
        -sampling-factor 4:4:4 \
        -define jpeg:dct-method=float \
        "${1%.psd}.jpg"
}

# convert PSD to WebP (lossless, smaller than PNG)
# usage: psd-to-webp <file.psd>
function psd-to-webp
{
    if [[ ! $# -eq 1 ]]; then
        echo "usage: psd-to-webp <file.psd>"
        return 1
    fi

    magick "$1[0]" \
        -alpha on \
        -define webp:lossless=true \
        "${1%.psd}.webp"
}

# convert PSD to all useful formats
# usage: psd-to-all <file.psd>
function psd-to-all
{
    if [[ ! $# -eq 1 ]]; then
        echo "usage: psd-to-all <file.psd>"
        return 1
    fi

    psd-to-png  "$1" || return 1
    psd-to-tiff "$1" || return 1
    psd-to-jpg  "$1" || return 1
    psd-to-webp "$1" || return 1
}


# batch convert WebP images to PNG and remove originals
# guarantees:
#  - lossless preservation of decoded pixels
#  - preserve image dimensions and transparency
#  - never overwrite existing PNG files
#  - delete WebP only after successful conversion and verification
#  - leave all other image formats untouched
#  - skip animated WebP to preserve animation
#  - preserve filenames except for the extension
# strategy:
#  - ImageMagick mogrify -format png -path
#  - scan one directory level by default; -r enables recursion
#  - stage conversions in isolated temporary directories
#  - verify PNG format, dimensions, and pixel equality
#  - publish via hard link to prevent overwrites
#  - clean temporary files even on interruption
#  - preview by default; only modify with --apply
# usage: webp-to-png <directory> [-r|--recursive] [--apply]
function webp-to-png
{
    # ---------- arguments ----------
    local input=""
    local mode="preview"
    local recursive=0

    for arg in "$@"; do
        case "$arg" in
            -h|--help)
                cat <<'EOF'
usage: webp-to-png <directory> [options]

Convert static WebP images to PNG and remove the originals.

options:
  -h, --help       Show this help message
  -r, --recursive  Process all nested directories
  --apply          Convert and delete originals (default: preview)

behavior:
  - Default depth: 1 (immediate files only)
  - Preserve original filenames except for the extension
  - Skip animated WebP and existing PNG destinations
  - Verify decoded pixels before deleting original WebP
  - Leave all other file formats unchanged

examples:
  webp-to-png .
  webp-to-png . --apply
  webp-to-png . -r
  webp-to-png . -r --apply
EOF
                return 0
                ;;
            -r|--recursive)
                recursive=1
                ;;
            --apply)
                mode="apply"
                ;;
            -*)
                echo "webp-to-png: unknown option '$arg'"
                return 1
                ;;
            *)
                if [[ -n "$input" ]]; then
                    echo "webp-to-png: multiple directories specified"
                    return 1
                fi
                input="$arg"
                ;;
        esac
    done

    if [[ -z "$input" || ! -d "$input" ]]; then
        echo "usage: webp-to-png <directory> [-r|--recursive] [--apply]"
        return 1
    fi

    # ---------- dependencies ----------
    if ! command -v magick >/dev/null 2>&1; then
        echo "webp-to-png: ImageMagick not found in PATH"
        echo "Install with: brew install imagemagick"
        return 1
    fi

    if ! command -v mktemp >/dev/null 2>&1; then
        echo "webp-to-png: mktemp not found in PATH"
        return 1
    fi

    # ---------- discovery ----------
    local root="${input:A}"
    local manifest

    manifest=$(mktemp) || {
        echo "webp-to-png: could not create temporary manifest"
        return 1
    }

    local scan_rc=0

    if (( recursive )); then
        find "$root" -type f -iname '*.webp' \
            -print0 > "$manifest" || scan_rc=1
    else
        find "$root" ! -path "$root" -prune \
            -type f -iname '*.webp' \
            -print0 > "$manifest" || scan_rc=1
    fi

    if (( scan_rc )); then
        echo "webp-to-png: directory scan failed"
        rm -f "$manifest"
        return 1
    fi

    # ---------- report ----------
    echo "== webp-to-png =="
    echo "Path  : $root"
    echo "Mode  : ${mode:u}"
    echo "Depth : $([[ $recursive -eq 1 ]] && echo Recursive || echo 1)"
    echo

    local file output stage staged
    local probe format dimensions verified
    local converted=0 skipped=0 failed=0

    # ---------- execution ----------
    {
        while IFS= read -r -d '' file; do
            stage=""

            {
                output="${file%.*}.png"

                # ---------- source check ----------
                if [[ ! -f "$file" || -L "$file" ]]; then
                    echo "SKIP: '${file:t}' (source unavailable)"
                    (( skipped += 1 ))
                    continue
                fi

                # ---------- destination check ----------
                if [[ -e "$output" || -L "$output" ]]; then
                    echo "SKIP: '${file:t}' (PNG already exists)"
                    (( skipped += 1 ))
                    continue
                fi

                # ---------- probe ----------
                if ! probe=$(magick identify -ping \
                    -format '%m %wx%h\n' "$file" 2>/dev/null); then
                    echo "ERROR: '${file:t}' (cannot identify image)"
                    (( failed += 1 ))
                    continue
                fi

                if [[ -z "$probe" ]]; then
                    echo "ERROR: '${file:t}' (invalid image)"
                    (( failed += 1 ))
                    continue
                fi

                if [[ "$probe" == *$'\n'* ]]; then
                    echo "SKIP: '${file:t}' (animated WebP)"
                    (( skipped += 1 ))
                    continue
                fi

                format="${probe%% *}"
                dimensions="${probe#* }"

                if [[ "$format" != "WEBP" ]]; then
                    echo "SKIP: '${file:t}' (not a WebP image)"
                    (( skipped += 1 ))
                    continue
                fi

                # ---------- preview ----------
                echo "'${file:t}'"
                echo "  -> '${output:t}'"

                if [[ "$mode" == "preview" ]]; then
                    (( converted += 1 ))
                    echo
                    continue
                fi

                # ---------- staging ----------
                if ! stage=$(mktemp -d \
                    "${file:h}/.webp-to-png.XXXXXXXX"); then
                    echo "ERROR: could not create temporary directory"
                    (( failed += 1 ))
                    echo
                    continue
                fi

                staged="$stage/${output:t}"

                # ---------- conversion ----------
                if ! magick mogrify \
                    -format png \
                    -path "$stage" \
                    "$file"; then

                    echo "ERROR: mogrify conversion failed"
                    (( failed += 1 ))
                    echo
                    continue
                fi

                # ---------- verification ----------
                verified=$(magick identify +ping \
                    -format '%m %wx%h' "$staged" 2>/dev/null)

                if [[ ! -s "$staged" ||
                      "$verified" != "PNG $dimensions" ]]; then
                    echo "ERROR: PNG verification failed"
                    (( failed += 1 ))
                    echo
                    continue
                fi

                # Compare decoded pixels, including transparency.
                if ! magick compare -metric AE \
                    "$file" "$staged" null: \
                    >/dev/null 2>&1; then

                    echo "ERROR: pixel comparison failed"
                    (( failed += 1 ))
                    echo
                    continue
                fi

                # ---------- publish ----------
                # Hard linking fails if the destination exists.
                # Staging and output are on the same filesystem.
                if ! ln "$staged" "$output"; then
                    echo "ERROR: could not publish PNG"
                    (( failed += 1 ))
                    echo
                    continue
                fi

                # ---------- cleanup ----------
                if rm "$file"; then
                    echo "OK: converted and removed original"
                    (( converted += 1 ))
                else
                    echo "ERROR: PNG saved, but WebP could not be removed"
                    (( failed += 1 ))
                fi

                echo

            } always {
                # Clean this image's staging directory.
                if [[ -n "$stage" && -d "$stage" ]]; then
                    if ! rm -rf "$stage"; then
                        echo "ERROR: could not clean staging directory"
                        (( failed += 1 ))
                    fi
                fi
                stage=""
            }

        done < "$manifest"

    } always {
        # Clean the discovery manifest, including on interruption.
        rm -f "$manifest"
    }

    # ---------- summary ----------
    echo "== summary =="

    if [[ "$mode" == "preview" ]]; then
        echo "Would convert: $converted"
    else
        echo "Converted    : $converted"
    fi

    echo "Skipped      : $skipped"
    echo "Errors       : $failed"

    (( failed == 0 ))
}
