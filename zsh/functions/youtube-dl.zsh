
# usage: dl <youtube video url>
function dl
{
    youtube-dl --no-playlist \
               --merge-output-format mp4 \
               -f 'bestvideo+bestaudio' $@
}

# usage: dl-pl <youtube playlist url>
function dl-pl
{
    youtube-dl --yes-playlist --ignore-errors \
               --merge-output-format mp4 \
               -f 'bestvideo+bestaudio' $@
}

# usage: hqdl <youtube video url>
function hqdl
{
    youtube-dl --no-playlist \
               --merge-output-format mp4 \
               -f 'bestvideo[ext=webm]+bestaudio[ext=webm]/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' $@
}

# usage: hqdl-pl <youtube playlist url>
function hqdl-pl
{
    youtube-dl --yes-playlist --ignore-errors \
               --merge-output-format mp4 \
               -f 'bestvideo[ext=webm]+bestaudio[ext=webm]/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' $@
}

# usage: dl-audio <youtube video url>
function dl-audio
{
    youtube-dl --extract-audio \
               --audio-format mp3 \
               --audio-quality 0 $@
}

# usage: dl-360 <youtube video url>
function dl-360
{
    dl --user-agent \"\" $@
}
