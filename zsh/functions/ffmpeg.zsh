
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
# strategy:
#  - HEVC + 'hev1'        -> lossless tag fix to 'hvc1' (stream copy)
#  - HEVC (other tag)     -> MP4 remux with 'hvc1' (stream copy)
#  - H.264 / MPEG-4       -> MP4 remux (stream copy)
#  - everything else      -> re-encode to H.264/AAC MP4
# usage: fix-quicklook <media>
function fix-quicklook
{
    if [[ ! $# -eq 1 ]]; then
        echo "usage: fix-quicklook <media>"
        return 1
    fi

    local input="$1"

    if [[ ! -f "$input" ]]; then
        echo "fix-quicklook: '$input' not found"
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

    echo "== fix-quicklook =="
    echo "Input : $input"

    local codec tag format duration width height
    codec=$(ffprobe -v error -select_streams v:0 \
             -show_entries stream=codec_name \
             -of default=nw=1:nk=1 "$input")
    tag=$(ffprobe -v error -select_streams v:0 \
             -show_entries stream=codec_tag_string \
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
        echo "fix-quicklook: could not detect video stream (codec)."
        return 1
    fi

    echo "Codec : $codec"
    [[ -n "$tag" ]] && echo "Tag   : $tag"
    [[ -n "$format" ]] && echo "Format: $format"
    if [[ -n "$duration" ]]; then
        printf "Length: %.1f seconds\n" "$duration"
    fi
    if [[ -n "$width" && -n "$height" ]]; then
        echo "Res   : ${width}x${height}"
    fi

    local base="${input%.*}"
    local output mode will_transcode=0

    # Case 1: HEVC with 'hev1' tag -> lossless tag fix
    if [[ "$codec" == "hevc" && "$tag" == "hev1" ]]; then
        output="${base}_hvc1.mp4"
        mode="HEVC + 'hev1' → lossless tag fix to 'hvc1' (stream copy)"

    # Case 2: HEVC (any other tag, including hvc1/empty) -> MP4 remux with 'hvc1'
    elif [[ "$codec" == "hevc" ]]; then
        output="${base}_qt.mp4"
        mode="HEVC ($tag) → MP4 remux with 'hvc1' (stream copy)"

    # Case 3: H.264 / MPEG-4 -> MP4 remux
    elif [[ "$codec" == "h264" || "$codec" == "mpeg4" ]]; then
        output="${base}_qt.mp4"
        mode="$codec → MP4 remux (stream copy)"

    # Case 4: everything else (vp9, av1, etc.) -> re-encode
    else
        output="${base}_qt.mp4"
        mode="Non-Apple-friendly codec ($codec) → re-encode to H.264/AAC MP4"
        will_transcode=1
    fi

    echo "Mode  : $mode"

    # Tell you upfront if it might take a while
    if (( will_transcode )); then
        if [[ -n "$duration" ]]; then
            local dur_int=${duration%.*}
            if (( dur_int > 1800 )); then
                echo "Note : This will re-encode ~${dur_int}s (~$(($dur_int/60)) min) of video at ${width}x${height}."
                echo "       ⚠ This is a long job and may take quite a while depending on your CPU."
            elif (( dur_int > 300 )); then
                echo "Note : Re-encoding ~${dur_int}s (~$(($dur_int/60)) min) of video; this may take a bit."
            else
                echo "Note : Re-encoding a short clip (~${dur_int}s); should be relatively quick."
            fi
        else
            echo "Note : Re-encoding; duration unknown, may take a while depending on length/resolution."
        fi
    else
        echo "Note : Stream copy only (no re-encode); this should be very fast."
    fi

    # Actually run ffmpeg
    if (( will_transcode )); then
        echo "ffmpeg: transcode video to libx264, audio to AAC"
        ffmpeg -hide_banner -loglevel error \
            -i "$input" \
            -c:v libx264 -crf 18 -preset medium \
            -c:a aac -b:a 128k \
            "$output"
    else
        if [[ "$codec" == "hevc" ]]; then
            echo "ffmpeg: stream copy with -tag:v hvc1"
            ffmpeg -hide_banner -loglevel error \
                -i "$input" -c copy -tag:v hvc1 "$output"
        else
            echo "ffmpeg: stream copy to MP4"
            ffmpeg -hide_banner -loglevel error \
                -i "$input" -c copy "$output"
        fi
    fi

    local status=$?
    if [[ $status -eq 0 ]]; then
        echo "✅ Output: $output"
    else
        echo "❌ ffmpeg failed (exit code $status)"
    fi

    return $status
}
