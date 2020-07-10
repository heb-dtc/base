#!/bin/bash

server='casimir.curious-company.com'
port=22

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
  echo "connecting to tunnel at $server on port $port for user $user"
  ssh $user@$server -p $port -CN -L5027:localhost:5037 -R27183:localhost:27183
}

openTunnel() {
  echo "opening tunnel to $server on port $port for user $user"
  ssh $user@$server -p $port -CN -R5027:localhost:5037 -L27183:localhost:27183
}

main() {

  case "$1" in 
    ''|-h|--help)
      usage
      exit 0
      ;;
  esac

  while getopts "m:s:p:u:" option
  do
    case "${option}"
      in
      m) mode=${OPTARG};;     
      u) user=${OPTARG};;
      s) server=${OPTARG};;
      p) port=${OPTARG};;
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
