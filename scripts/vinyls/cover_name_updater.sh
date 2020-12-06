#!/bin/bash

# given an input json file of the form 
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
#
# this script will set all cover entries with the value /vinyls/artistName-albumName.jpg  
# all spaces found in artistName and albumName are replaced with "_" in the cover value
# the input file will kept the same form but will be updated

file=$1

# command break down
# jq '{foo: [ .[] ]}' -> produce a JSON object with an entry foo that holds an array containing what jq read
# .cover="/vinyls/"+ .artist + "-" + .album + ".jpg" -> affect to cover the values of artist and album fields 
# .cover |= (split(" ")|join("_")) -> update the cover value, replacing " " with "_"

cat $file | jq '{albums: [.albums[] | .cover="/vinyls/"+ .artist + "-" + .album + ".jpg" | .cover |= (split(" ")|join("_"))] }' > $1.tmp

rm $1
mv $1.tmp $1


