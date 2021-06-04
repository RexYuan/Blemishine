
function dl
{
    youtube-dl --no-playlist \
               --merge-output-format mp4 \
               -f 'bestvideo+bestaudio' $@
}

function dl-pl
{
    youtube-dl --yes-playlist --ignore-errors \
               --merge-output-format mp4 \
               -f 'bestvideo+bestaudio' $@
}

function hqdl
{
    youtube-dl --no-playlist \
               --merge-output-format mp4 \
               -f 'bestvideo[ext=webm]+bestaudio[ext=webm]/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' $@
}

function hqdl-pl
{
    youtube-dl --yes-playlist --ignore-errors \
               --merge-output-format mp4 \
               -f 'bestvideo[ext=webm]+bestaudio[ext=webm]/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' $@
}

function dl-audio
{
    youtube-dl --extract-audio \
               --audio-format mp3 \
               --audio-quality 0 $@
}

function dl-360
{
    dl --user-agent \"\" $@
}
