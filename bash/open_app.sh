#!/bin/bash
adb='/home/flamine/Android/Sdk/platform-tools/adb'
# open app
$adb shell am start -W -n com.onlyoffice.documents/com.onlyoffice.documents.activities.MainActivity
sleep 5