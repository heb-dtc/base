#!/bin/bash
intern=eDP1
#extern=DP3-3
#externTwo=DP1
extern=DP1

usage() {
    local programName
    programName=${0##*/}
    cat <<EOF
Usage: $programName [-option]

Options:
    --help Print this message
    -dual Dual screen setup
    -three Three screens setup
    -extern Only external screen setup
    -intern Only internal screen setup
    -frgb Apply full rgb mode to external screen to have real blacks
EOF
}   

setupScreen() {
    mode=$1

    if [ "$mode" == "extern" ]; then
        if xrandr | grep "$extern disconnected"; then
            echo "external screen not detected. Is it plugged?"
            exit 1
        fi
        xrandr --output "$intern" --off --output "$extern" --auto
    elif [ "$mode" == "intern" ]; then
        xrandr --output "$extern" --off --output "$intern" --auto
    elif [ "$mode" == "dual" ]; then
        xrandr --output "$extern" --above "$intern" --auto
    elif [ "$mode" == "three" ]; then
        xrandr --output "$extern" --above "$externTwo" --right-of "$intern" --auto
    fi
}

fullRgb() {
    xrandr --output $extern --set "Broadcast RGB" "Full"
}

main() {
    case "$1" in 
        ''|-h|--help)
            usage
            exit 0
            ;;
    -dual)
        setupScreen dual
        ;;
    -intern)
        setupScreen intern
        ;;
    -extern)
        setupScreen extern
        ;;
    -frgb)
        fullRgb
        ;;
    *)
        echo "Command not found"
        exit 1
        ;;
    esac
}

main "$@"
