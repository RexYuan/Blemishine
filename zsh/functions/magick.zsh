
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
