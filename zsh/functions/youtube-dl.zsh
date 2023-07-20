
# usage: dl <youtube video url>
function dl
{
    yt-dlp --no-playlist \
           --merge-output-format mp4 \
           -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' $@
}

function dl-live
{
    yt-dlp -w --write-description \
              --write-thumbnail \
              --embed-thumbnail \
              --live-from-start \
              --wait-for-video 15 \
              --sleep-subtitles 1 \
              --download-archive .archive \
              --progress --merge-output-format mp4 \
              -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' \
              --add-metadata \
              --write-info-json \
              --write-annotations \
              --cookies cookies.txt $@
}

# usage: dl-pl <youtube playlist url>
function dl-pl
{
    yt-dlp --yes-playlist --ignore-errors \
               --merge-output-format mp4 \
               -f 'bestvideo+bestaudio' $@
}

# usage: hqdl <youtube video url>
function hqdl
{
    yt-dlp --no-playlist \
               --merge-output-format mp4 \
               -f 'bestvideo[ext=webm]+bestaudio[ext=webm]/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' $@
}

# usage: hqdl-pl <youtube playlist url>
function hqdl-pl
{
    yt-dlp --yes-playlist --ignore-errors \
               --merge-output-format mp4 \
               -f 'bestvideo[ext=webm]+bestaudio[ext=webm]/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' $@
}

# usage: dl-audio <youtube video url>
function dl-audio
{
    yt-dlp --extract-audio \
               --audio-format mp3 \
               --audio-quality 0 $@
}

# usage: dl-360 <youtube video url>
function dl-360
{
    dl --user-agent \"\" $@
}
