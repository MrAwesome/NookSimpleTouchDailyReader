#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

. ./rubyreader/lib.sh

./rubyreader/run.sh

DT=$(date "+%Y%m%d_%H%M")

for format in $FORMATS; do
    INPUTFILENAME="${OUTF}.${format}"
    PLAININPUTFILENAME="${OUTF}_plain.${format}"
    DATEFILENAME="${DT}.${format}"
    PLAINDATEFILENAME="${DT}_plain.${format}"

    cp rubyreader/"$BUILD_DIR"/"${INPUTFILENAME}" ~/public_html/"$DATEFILENAME"
    cp rubyreader/"$BUILD_DIR"/"${PLAININPUTFILENAME}" ~/public_html/"$PLAINDATEFILENAME"
    ln -sf "$PLAINDATEFILENAME" ~/public_html/"${PLAININPUTFILENAME}"
    ln -sf "$DATEFILENAME" ~/public_html/"${INPUTFILENAME}"
done

echo "$DT" > ~/public_html/most_recent.txt
