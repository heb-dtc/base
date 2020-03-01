OUTPUT_DIR_SUFFIX="/build/outputs/apk"
GIF_DESTINATION_FOLDER="/home/$USER/gif"
SCREENSHOT_DESTINATION_FOLDER="/home/$USER/screenshot"
FFMPEG="ffmpeg"
AVCONV="avconv"
TAB_KEY=61
ENTER_KEY=66

function listAlarmsFor() {
    if [ $# -ne 1 ]; then
        echo "Usage: provide package name"
        echo "Example: com.my.package"
        return
    fi

    local package=$1

    adb shell dumpsys alarm | grep $package -A5
}

function startMainActivity() {
    if [ $# -ne 1 ]; then
        echo "Usage: provide package name and activity name"
        echo "Example: com.my.app/.myPackage.MyActivity"
        return
    fi

    local activity=$1

    adb shell am start -n $activity -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
}

function appLogin() {
     if [ $# -ne 2 ]; then
        echo "Usage: provide a username and a password"
        echo "Example: appLogin user pass"
        return
    fi
    
    local user=$1
    local pass=$2

    adb shell input text $user && adb shell input keyevent $TAB_KEY && adb shell input text $pass && adb shell input keyevent $ENTER_KEY
}

#nuke the local gradle cache
function cleanGradleCache() {
    if [ $# -ne 1 ]; then
        echo "Usage: provide the name of the dependency you wish to :burn:"
        echo "Example: cleanGradleCache com.android.support"
        return
    fi
    
    local id=$1

    find ~/.gradle/caches/ -type d -name "$id" -prune -exec rm -rf "{}" \; -print
}

function multipleDevices() {
    adb devices | wc -l 
}

#check if adb detects any devices, return TRUE if at least one is found, FALSE otherwise
function noDeviceConnected() {
    local number=$(adb devices | wc -l) 
    if [ $number = 2 ]; then
        return 1;
    fi
    
    return 0;
}

function deviceTcpConnect() {
    if [[ $(adb devices | wc -l) = 2 ]]; then
        echo "No adb device connected"
        return
    fi
    
    local deviceIp=$(adb shell ip addr show wlan0 | grep -Eo 'inet ([0-9]*\.){3}[0-9]*' | awk '{print $2}')
    echo "Attempting to connect device with IP" $deviceIp

    adb tcpip 5555
    adb connect $deviceIp:5555
}

function deviceTcpDisconnect() {
    adb usb
}

function deviceMakeGif() {
    #if noDeviceConnected; then
    #    echo "No adb device connected"
    #    return
    #fi

    if [ $# -ne 2 ]; then
        echo "Usage: provide a name for the gif and the time of recording in seconds"
        echo "Example: deviceMakeGif myGif 10">&2
        return
    fi

    if ! type "$FFMPEG" >/dev/null; then
       echo "ffmpeg not installed on this machine. Stopping here."
       return
    fi

    local gifName=$1.gif
    local gifPath=$GIF_DESTINATION_FOLDER/$gifName

    if [ ! -d "$GIF_DESTINATION_FOLDER" ]; then
        echo "Destination folder doesnt exist, creating it now..."
        mkdir $GIF_DESTINATION_FOLDER
    fi

    echo "Destination file:" $gifName
    echo "Destination folder:" $GIF_DESTINATION_FOLDER

    echo "Capturing device screen"
    echo "start recording for" $2 " seconds"
    adb shell screenrecord --bit-rate 4000000 --size 720x1280 --time-limit $2 /sdcard/recording.mp4

    echo "pulling video to" $GIF_DESTINATION_FOLDER
    adb pull /sdcard/recording.mp4 $GIF_DESTINATION_FOLDER

    local defaultHeight=500
    local defaultFps=15
    echo "video to gif"
    ffmpeg -i $GIF_DESTINATION_FOLDER/recording.mp4 -vf scale=$defaultHeight:-1,format=rgb8,format=rgb24 -r $defaultFps $gifPath

    echo "cleanup"
    rm $GIF_DESTINATION_FOLDER/recording.mp4

    echo "GIF at" $gifPath
}

function deviceMakeCustomGif() {
    if [ $# -ne 3 ]; then
        echo "Usage: provide a name for the gif, the path to the video file and the time to cut at the begining of the video"
        echo "Example: deviceMakeGif myGif myVideo 5">&2
        return
    fi

    if ! type "$FFMPEG" >/dev/null; then
       echo "ffmpeg not installed on this machine. Stopping here."
       return
    fi

    local gifName=$1.gif
    local gifPath=$GIF_DESTINATION_FOLDER/$gifName

    if [ ! -d "$GIF_DESTINATION_FOLDER" ]; then
        echo "Destination folder doesnt exist, creating it now..."
        mkdir $GIF_DESTINATION_FOLDER
    fi

    echo "Destination file:" $gifName
    echo "Destination folder:" $GIF_DESTINATION_FOLDER

    local defaultHeight=500
    local defaultFps=15
    echo "video to gif"
    ffmpeg -ss $3 -i $2 -vf scale=$defaultHeight:-1,format=rgb8,format=rgb24 -r $defaultFps $gifPath

    echo "GIF at" $gifPath
}

function deviceChangeDate() {
    local newDate=$1

    adb shell date -s newDate
}

function apkList() {
    if [ $# -ne 1 ]; then
        echo "Usage: provide the project name"
        echo "Example: apkList myProjectName" >&2
        return
    fi

    local apkPath=$PROJECT_NAME$OUTPUT_DIR_SUFFIX
    echo "listing content of" $apkPath

    ls $apkPath
}

function gradleBuild() {
    if [ $# -ne 1 ]; then
        echo "Usage: provide the flavor you wish to build"
        echo "Example: gradleBuild myFlavor" >&2
        return
    fi

    local flavor=$1

    echo "Building for flavor:" $flavor
    ./gradlew assemble$flavor
}

function getAppName() {
   ./gradlew properties | grep "ANDROID_MAIN_MODULE" | awk -F ": :" '{print $2}'
}

function deviceInstallLast() {
    if [ $# -ne 1 ]; then
        echo "Usage: provide the project name"
        echo "Example: deviceInstallLast myProjectName" >&2
        return
    fi

    local apkPath=$1$OUTPUT_DIR_SUFFIX
    local apkName=$(ls -t $apkPath | head -n1)
    local apk=$apkPath/$apkName

    echo "installing: " $apk

    adb install -r $apk

    local package=$(aapt dump badging $apk | awk -F " " '/package/ {print $2}' | awk -F "'" '/name=/ {print $2}')
    local activity=$(aapt dump badging $apk | awk -F " " '/launchable-activity/ {print $2}' | awk -F "'" '/name=/ {print $2}' | head -n1)

    echo "app package " $package
    echo "app main activity" $activity

    adb shell am start -n $package/$activity
}

function adbListDevice() {
    adb devices | tail -n+2 | cut -f1
}

function deviceCleanInstall() {
    if [ $# -ne 1 ]; then
        echo "Usage: provide the project name"
        echo "Example: deviceCleanInstall myProjectName" >&2
        return
    fi
    local apkPath=$1$OUTPUT_DIR_SUFFIX
    local apkName=$(ls -t $apkPath | head -n1)
    local apk=$apkPath/$apkName

    echo "installing: " $apk

    local package=$(aapt dump badging $apk | awk -F " " '/package/ {print $2}' | awk -F "'" '/name=/ {print $2}')
    local activity=$(aapt dump badging $apk | awk -F " " '/launchable-activity/ {print $2}' | awk -F "'" '/name=/ {print $2}' | head -n1)

    echo "app package " $package
    echo "app main activity" $activity

    adb shell pm clear $package
    adb install -r $apk
    adb shell am start -n $package/$activity
}

function deviceClean() {
    if [ $# -ne 1 ]; then
        echo "Usage: provide the project name"
        echo "Example: deviceClean myProjectName" >&2
        return
    fi
    local apkPath=$1$OUTPUT_DIR_SUFFIX
    local apkName=$(ls -t $apkPath | head -n1)
    local apk=$apkPath/$apkName

    echo "cleaning app: " $apk

    local package=$(aapt dump badging $apk | awk -F " " '/package/ {print $2}' | awk -F "'" '/name=/ {print $2}')
    local activity=$(aapt dump badging $apk | awk -F " " '/launchable-activity/ {print $2}' | awk -F "'" '/name=/ {print $2}' | head -n1)

    echo "app package " $package
    echo "app main activity" $activity

    adb shell pm clear $package
}

function deviceUnlock() {
    adb shell input keyevent 82
}

function deviceTakeScreenshot() {
    if [ $# -ne 1 ]; then
        echo "Usage: provide a name for the screenshot"
        echo "Example: deviceTakeScreenshot myScreenshot" >&2
        return
    fi

    local screenshotName=$1.png
    local screenshotPath=$SCREENSHOT_DESTINATION_FOLDER/$screenshotName

    if [ ! -d "$SCREENSHOT_DESTINATION_FOLDER" ]; then
        echo "Destination folder doesnt exist, creating it now..."
        mkdir $SCREENSHOT_DESTINATION_FOLDER
    fi

    echo "Destination file:" $screenshotName
    echo "Destination folder:" $SCREENSHOT_DESTINATION_FOLDER

    adb shell screencap -p | sed 's/\r$//' > $screenshotPath
}

function deviceChangeDate() {
    local newDate=$1

    adb shell date -s newDate
}

function deviceInstall() {
    local module=$(getAppName)
    local apkPath=$module$OUTPUT_DIR_SUFFIX
    local apkName=$(ls -t $apkPath | head -n1)
    local apk=$apkPath/$apkName

    echo "installing" $apk
    adb install -r $apk
}

function testAll() {
    ./gradlew test
}

function testSingle() {
    local testName=$1
    local moduleName=$1

    ./gradlew -Dtest.single=$testName $moduleName:test
}

function startDeviceAndRun() {
    local deviceStarted=$(gmtool admin start Nexus_9_dev_ready)

    echo $deviceStarted
}
