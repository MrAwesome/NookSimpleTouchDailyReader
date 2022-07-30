#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

. ./rubyreader/lib.sh

./rubyreader/run.sh

DT=$(date "+%Y%m%d_%H%M")

for format in $FORMATS; do
    DATEFILENAME="${DT}.${format}"

    cp rubyreader/"$BUILD_DIR"/"${OUTF}.${format}" ~/public_html/"$DATEFILENAME"
    ln -sf "$DATEFILENAME" ~/public_html/"${OUTF}.${format}"
done

echo "$DT" > ~/public_html/most_recent.txt
