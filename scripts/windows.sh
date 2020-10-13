#!/bin/bash

localAdbPort=5037
localScrcpyPort=27183

usage() {
    local programName
    programName=${0##*/}
    cat <<EOF
Usage: $programName [-option]

Options:
    --help Print this message
EOF
}   

connectToTunnel() {
  session=$(curl -s localhost:6666/sessions/$id)
  server=$(echo $session | jq '.server')
  port=$(echo $session | jq '.port')
  remoteAdbPort=$(echo $session | jq '.adbPort')
  remoteScrcpyPort=$(echo $session | jq '.scrcpyPort')

  echo "connecting to tunnel at $server on port $port for user $user"
  echo "with sessionId $sessionId"
  echo "remote adb server port is $remoteAdbPort"
  echo "remote scrcpy port is $remoteScrcpyPort"

  ssh $user@$server -p $port -CN -L5037:localhost:$remoteAdbServerPort -R$remoteScrcpyPort:localhost:27183
}

openTunnel() {
  session=$(curl -s localhost:6666/sessions/new)
  sessionId=$(echo $session | jq '.id')
  server=$(echo $session | jq '.server')
  port=$(echo $session | jq '.port')
  remoteAdbPort=$(echo $session | jq '.adbPort')
  remoteScrcpyPort=$(echo $session | jq '.scrcpyPort')

  echo "opening tunnel to $server on port $port for user $user"
  echo "sessionId is $sessionId"
  echo "remote adb server port is $remoteAdbPort"
  echo "remote scrcpy port is $remoteScrcpyPort"

  ssh $user@$server -p $port -CN -R$remoteAdbPort:localhost:5037 -L27183:localhost:$remoteScrcpyPort
}

main() {

  case "$1" in 
    ''|-h|--help)
      usage
      exit 0
      ;;
  esac

  while getopts "m:s:p:u:i:" option
  do
    case "${option}"
      in
      m) mode=${OPTARG};;     
      u) user=${OPTARG};;
      s) server=${OPTARG};;
      p) port=${OPTARG};;
      i) id=${OPTARG};;
    esac
  done

  if [[ -z $mode ]]; then
    echo "a mode need to be set -m {open,connect}"
    exit 1
  fi

  if [[ -z $user ]]; then
    echo "a valid user need to be set -u user"
    exit 1
  fi

  case $mode
    in
    open) 
      openTunnel
      ;;
    connect) 
      connectToTunnel
      ;;
    *) 
      echo "mode is not valid"
      exit 1
      ;;
  esac
}

main "$@"
