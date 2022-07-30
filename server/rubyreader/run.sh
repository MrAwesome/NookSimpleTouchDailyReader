#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

. ./lib.sh

#DT=$(date "+%Y%m%d_%H%M")

ruby main.rb

ebook-convert "$BUILD_DIR"/index.html "$BUILD_DIR"/"$OUTF"

#adb connect 192.168.1.97:5555
#adb shell 'rm /media/My\ Files/Books/today.epub' || true
#adb usb
#adb push "$OUTF" '/cache/news/'
#adb push "$OUTF" '/media/My Files/Books/'
