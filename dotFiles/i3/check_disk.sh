#!/bin/bash

DIR="/home/flow/dataz/"

if [ -d "$DIR" ]; then
  if [ "$(ls -A $DIR)" ]; then
    echo '{\"icon\":\"\uf0230\",\"state\":\"Critical\", \"text\": \"Danger!\"}'
  else
    echo '{\"icon\":\"\uf3c1\",\"state\":\"Critical\", \"text\": \"Danger!\"}'
  fi
else
  echo '{\"icon\":\"\uf06a\",\"state\":\"Critical\", \"text\": \"Danger!\"}'
fi
