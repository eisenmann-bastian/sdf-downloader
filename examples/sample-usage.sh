#!/bin/sh
set -eu

cd "$(dirname "$0")/.."
"${PYTHON:-python3}" downloader.py examples/sample-full.csv -o examples/sample_full_csv
"${PYTHON:-python3}" downloader.py examples/sample-mixed.csv -o examples/sample_mixed_csv --result-selection all