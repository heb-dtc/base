#!/bin/bash

# Fetch a cover on discog for the tuple (artist album) passed as args.
# The first cover image found in the result is downloaded and saved locally with the following pattern artist-name.jpg
# A valid token is needed for this to work

token="" 
artist=$1
album=$2

filter=$(echo $artist - $album)
coverName=$(echo $artist-$album.jpg | tr -d \")
coverName="${coverName// /_}"

coverUrl=$(curl -G "https://api.discogs.com/database/search?" -d release_title="${album}" -d artist="${artist}" -d format=vinyl -d token=$token | jq '.results[] | .cover_image' | head -n 1 | tr -d \")

echo " =============================== cover url is $coverUrl" 

(cd static/vinyls && curl -o ${coverName} $coverUrl)


