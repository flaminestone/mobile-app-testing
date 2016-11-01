#!/bin/bash
adb='/home/flamine/Android/Sdk/platform-tools/adb'
# open app
$adb shell am start -W -n com.onlyoffice.documents/com.onlyoffice.documents.activities.MainActivity
sleep 5 # wait for app is opened

$adb shell input tap 66 592 # click on portal address field
$adb shell input keyevent 111 #hide keybord
$adb shell input keyevent KEYCODE_MOVE_END # move cursore on end
for i in `seq 1 40`; # delete 30 symbols from field
	do
		$adb shell input keyevent KEYCODE_DEL
	done  

$adb shell input text 'mobile-test.teamlab.info' #add new portal address


$adb shell input tap 100 725 # click on portal email field
$adb shell input keyevent 111 #hide keybord
$adb shell input keyevent KEYCODE_MOVE_END
for i in `seq 1 40`; # delete 30 symbols from field
	do
		$adb shell input keyevent KEYCODE_DEL
	done    
$adb shell input text 'john.dorian@tm-runner.no-ip.org' #add new portal email

$adb shell input tap 100 845 # click on portal password field
$adb shell input keyevent 111 #hide keybord
$adb shell input text '123456' # add new portal password

$adb shell input tap 350 1028 # click on portal password field