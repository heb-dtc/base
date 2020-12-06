#!/bin/bash

# Take into input a JSON file with a list of album entries with the following format:
# {
#   albums: [
#    {
#      artist: artistName,
#      album: albumName,
#      cover: url
#    },
#  ...
#   ]
# }
# Grab the artist name and album name and fetch a cover for the tuple.

file=$1

# Create dummy input
cat $file | jq '.albums[] | .artist,.album' >> input-file.txt 
# Create new file handle 5
exec 5< input-file.txt

# Now you can use "<&5" to read from this file
while read line1 <&5 ; do
        read line2 <&5

        echo "========================================== fetching cover for $line1 $line2"
        ./fetch_album_cover.sh "$line1" "$line2"
done

# Close file handle 5
exec 5<&-
rm input-file.txt

