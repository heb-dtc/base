#!/bin/bash

SUBTITLES_DIR=$1
SUBTITLE_LANG=$2

# first find the subtitle file name for LANG
SUBTITLE_FILE=$(ls -t $SUBTITLES_DIR/*$SUBTITLE_LANG | head -1)
echo --- found subtitle file -> $SUBTITLE_FILE

# find media file name in current dir
MEDIA_FILE=$(basename $(ls -t *.mp4 | head -1) .mp4)

# copy file to current directory and rename it according to video file

cp $SUBTITLES_DIR/$SUBTITLE_FILE $MEDIA_FILE.srt

#for dir in Subs/*/; do name="${dir%/}"; name="${name##*/}"; outputFile="$name.srt"; srtFile=10_English.srt; originFile="$dir$srtFile"; cp $originFile $outputFile; done;
