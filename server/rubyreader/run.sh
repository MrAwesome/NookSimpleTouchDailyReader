#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

. ./lib.sh

#DT=$(date "+%Y%m%d_%H%M")

mkdir -p "$BUILD_DIR"

ruby main.rb

for format in $FORMATS; do
    ebook-convert "$BUILD_DIR"/index.html "$BUILD_DIR"/"$OUTF.${format}" --output-profile=nook
done

#adb connect 192.168.1.97:5555
#adb shell 'rm /media/My\ Files/Books/today.epub' || true
#adb usb
#adb push "$OUTF" '/cache/news/'
#adb push "$OUTF" '/media/My Files/Books/'
