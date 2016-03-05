DEFAULT_OUTPUT_FILE="output.gif"
SIZE="640x480"
PIX_FORMAT="rgb24"
FPS="10"
DEFAULT_START_POS="00:00:00.000"
DEFAULT_DURATION="00:00:10.000"

function gifItUp() {
    if [ $# -eq 0 ]; then
        echo "Usage: provide file, start pos and duration"
        echo "Example: gifItUp <fileName> <00:00:00.000> <00:00:00.000>" >&2
        return
    fi

    local file=$1

    if [ -z "$2" ]; then
        local startPos=$DEFAULT_START_POS
        echo "Using default start position" $startPos
    fi

    if [ -z "$3" ]; then
        local duration=$DEFAULT_DURATION
        echo "Using default duration" $duration
    fi

    local startPos=$2
    local duration=$3

    ffmpeg -ss $DEFAULT_START_POS -i $file -pix_fmt $PIX_FORMAT -r $FPS -s $SIZE -t $DEFAULT_DURATION $DEFAULT_OUTPUT_FILE
}
