#!/bin/bash
adb='/home/flamine/Android/Sdk/platform-tools/adb'
# open app
$adb shell am start -W -n com.onlyoffice.documents/com.onlyoffice.documents.activities.MainActivity
sleep 3
$adb shell input tap 226 226 # click on portal address field
sleep 10