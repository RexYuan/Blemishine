
# https://stackoverflow.com/q/3255674/2448540
# convert/extract any media to mp3
# usage: to-mp3 <media>
function to-mp3
{
    if [[ ! $# -eq 1 ]]; then
        echo "usage: to-mp3 <media>"
        return 1
    fi
    ffmpeg -i "$1" -vn -ar 44100 -ac 2 -b:a 192k "${1%.*}.mp3"
}

# https://superuser.com/q/1041816/372113
# make mp4 from song and still image
# usage: mp3vid <image> <music>
function mp3vid
{
    if [[ ! $# -eq 2 ]]; then
        echo "usage: mp3vid <image> <music>"
        return 1
    fi
    ffmpeg -loop 1 -i "$1" -i "$2" -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest "${1%.*} with ${2%.*}.mp4"
}

# https://superuser.com/q/624565/372113
# convert flv to mp4
# usage: flv-to-mp4 <flv media>
function flv-to-mp4
{
    if [[ ! $# -eq 1 || $1 != *.flv ]]; then
        echo "usage: flv-to-mp4 <flv media>"
        return 1
    fi
    ffmpeg -i "$1" -c:v libx264 -crf 19 -strict experimental "${1%.*}.mp4"
}

# make a video as Quick Look–friendly as possible on macOS
# guarantees:
#  - zero quality loss WHEN Apple can decode the source
#  - unavoidable single-step loss ONLY when Apple cannot
# strategy:
#  - HEVC + hev1 + 8-bit yuv420p -> lossless tag fix to hvc1
#  - HEVC + 8-bit yuv420p        -> MP4 remux with hvc1
#  - AVC  + yuv420p              -> MP4 remux (container-dependent; FLV may fail)
#  - everything else             -> transcode ONCE to AVC/AAC (visually lossless)
# usage: fix-quicklook <media> [media ...]
function fix-quicklook
{
    if (( $# == 0 )); then
        echo "usage: fix-quicklook <media> [media ...]"
        return 1
    fi

    if ! command -v ffprobe >/dev/null 2>&1; then
        echo "fix-quicklook: ffprobe not found in PATH"
        return 1
    fi
    if ! command -v ffmpeg >/dev/null 2>&1; then
        echo "fix-quicklook: ffmpeg not found in PATH"
        return 1
    fi

    local overall_rc=0

    for input in "$@"; do
        echo "== fix-quicklook =="

        if [[ ! -f "$input" ]]; then
            echo "fix-quicklook: '$input' not found"
            overall_rc=1
            echo
            continue
        fi

        echo "Input : $input"

        # ---------- probe ----------
        local codec tag format duration width height pix_fmt bit_depth
        codec=$(ffprobe -v error -select_streams v:0 \
            -show_entries stream=codec_name \
            -of default=nw=1:nk=1 "$input")
        tag=$(ffprobe -v error -select_streams v:0 \
            -show_entries stream=codec_tag_string \
            -of default=nw=1:nk=1 "$input")
        pix_fmt=$(ffprobe -v error -select_streams v:0 \
            -show_entries stream=pix_fmt \
            -of default=nw=1:nk=1 "$input")
        bit_depth=$(ffprobe -v error -select_streams v:0 \
            -show_entries stream=bits_per_raw_sample \
            -of default=nw=1:nk=1 "$input")
        format=$(ffprobe -v error \
            -show_entries format=format_name \
            -of default=nw=1:nk=1 "$input")
        duration=$(ffprobe -v error \
            -show_entries format=duration \
            -of default=nw=1:nk=1 "$input")
        width=$(ffprobe -v error -select_streams v:0 \
            -show_entries stream=width \
            -of default=nw=1:nk=1 "$input")
        height=$(ffprobe -v error -select_streams v:0 \
            -show_entries stream=height \
            -of default=nw=1:nk=1 "$input")

        if [[ -z "$codec" ]]; then
            echo "fix-quicklook: could not detect video stream"
            overall_rc=1
            echo
            continue
        fi

        # Friendly names for display
        local vcodec_name="$codec"
        if [[ "$codec" == "h264" ]]; then
            vcodec_name="AVC (h264)"
        elif [[ "$codec" == "hevc" ]]; then
            vcodec_name="HEVC (hevc)"
        fi

        echo "Codec : $vcodec_name"
        [[ -n "$tag" ]]      && echo "Tag   : $tag"
        [[ -n "$pix_fmt" ]]  && echo "Pix   : $pix_fmt"
        [[ -n "$bit_depth" ]]&& echo "Bits  : $bit_depth"
        [[ -n "$format" ]]   && echo "Format: $format"
        [[ -n "$duration" ]] && printf "Length: %.1f seconds\n" "$duration"
        [[ -n "$width" && -n "$height" ]] && echo "Res   : ${width}x${height}"

        local base="${input%.*}"
        local output="${base}_qt.mp4"
        local try_remux=0
        local will_transcode=0
        local is_hevc=0

        # ---------- decision ----------
        if [[ "$codec" == "hevc" && "$pix_fmt" == "yuv420p" && "$bit_depth" != "10" ]]; then
            echo "Mode  : HEVC (8-bit yuv420p) → MP4 remux + hvc1 (lossless)"
            try_remux=1
            is_hevc=1

        elif [[ "$codec" == "h264" && "$pix_fmt" == "yuv420p" ]]; then
            echo "Mode  : AVC (yuv420p) → MP4 remux (may fail for FLV)"
            try_remux=1

        else
            echo "Mode  : Unsupported by Quick Look → transcode ONCE to AVC/AAC"
            will_transcode=1
        fi

        # ---------- execution ----------
        local rc=0

        if (( try_remux )); then
            echo "ffmpeg: attempting stream copy (+faststart)"
            if (( is_hevc )); then
                ffmpeg -hide_banner -loglevel error \
                    -i "$input" \
                    -c copy -movflags +faststart -tag:v hvc1 \
                    "$output"
            else
                ffmpeg -hide_banner -loglevel error \
                    -i "$input" \
                    -c copy -movflags +faststart \
                    "$output"
            fi

            rc=$?
            if [[ $rc -eq 0 ]]; then
                echo "✅ Output (lossless): $output"
                echo
                continue
            fi

            echo "⚠ Lossless remux failed; falling back to transcode."
            will_transcode=1
        fi

        if (( will_transcode )); then
            if [[ -n "$duration" ]]; then
                local dur_int=${duration%.*}
                if (( dur_int > 3600 )); then
                    echo "Note : Transcoding ~$(($dur_int/60)) minutes at ${width}x${height}. This will take a long time."
                elif (( dur_int > 1800 )); then
                    echo "Note : Transcoding ~$(($dur_int/60)) minutes at ${width}x${height}."
                elif (( dur_int > 300 )); then
                    echo "Note : Transcoding ~$(($dur_int/60)) minutes."
                else
                    echo "Note : Transcoding ~${dur_int}s."
                fi
            else
                echo "Note : Transcoding (duration unknown)."
            fi

            echo "ffmpeg: transcode → AVC (H.264) CRF 16 + AAC"
            ffmpeg -hide_banner -loglevel error \
                -i "$input" \
                -map 0:v:0 -map '0:a?' \
                -c:v libx264 -preset slow -crf 16 \
                -pix_fmt yuv420p \
                -movflags +faststart \
                -c:a aac -b:a 160k \
                "$output"

            rc=$?
            if [[ $rc -eq 0 ]]; then
                echo "✅ Output (transcoded): $output"
            else
                echo "❌ ffmpeg failed (exit code $rc)"
                overall_rc=1
            fi
        fi

        echo
    done

    return $overall_rc
}
