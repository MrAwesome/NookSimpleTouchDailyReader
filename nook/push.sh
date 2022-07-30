#!/bin/bash

adb connect $1
adb push nook/skeleton/system/bin/* /system/bin
adb shell chmod 755 /system/bin/*.sh
