#!/bin/bash

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
  user=$1
  server=$2
  port=$3
  ssh $user@$server -p $port -CN -L5027:localhost:5037 -R27183:localhost:27183
}

openTunnel() {
  user=$1
  server=$2
  port=$3
  ssh $user@$server -p $port -CN -R5027:localhost:5037 -L27183:localhost:27183
}

main() {
  case "$1" in 
    ''|-h|--help)
      usage
      exit 0
      ;;

    -forward)
      openTunnel $2 $3 $4
      ;;
    -listen)
      connectToTunnel $2 $3 $4
      ;;
    *)
      echo "Command not found :("
      exit 1
      ;;

  esac
}

main "$@"
