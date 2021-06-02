
mapargs () {
    for arg in ${@:2}
    do
        $1 $arg
    done
}

function hqdl () {
    youtube-dl -f "bestvideo+bestaudio" --merge-output-format mp4 $1
}
