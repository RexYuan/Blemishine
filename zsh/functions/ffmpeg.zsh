
# https://stackoverflow.com/q/3255674/2448540
# convert/extract any media to mp3
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
function flv-to-mp4
{
    if [[ ! $# -eq 1 || $1 != *.flv ]]; then
        echo "usage: flv-to-mp4 <flv media>"
        return 1
    fi
    ffmpeg -i "$1" -c:v libx264 -crf 19 -strict experimental "${1%.*}.mp4"
}
