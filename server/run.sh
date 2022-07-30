#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

. ./rubyreader/lib.sh

./rubyreader/run.sh

DT=$(date "+%Y%m%d_%H%M")

DATEFILENAME="${DT}.epub"

cp rubyreader/"$BUILD_DIR"/"$OUTF" ~/public_html/"$DATEFILENAME"
ln -sf "$DATEFILENAME" ~/public_html/"$OUTF"
