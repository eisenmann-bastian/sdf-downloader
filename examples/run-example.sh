#!/bin/sh
set -eu
root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
if [ "$#" -gt 1 ]; then
    echo "Usage: $0 [output-directory]" >&2
    exit 2
fi
venv="$root/.venv"
if [ ! -e "$venv" ] && [ ! -L "$venv" ]; then
    "$root/examples/setup-venv.sh" "$venv"
fi
if [ ! -f "$venv/bin/activate" ] || [ ! -x "$venv/bin/python" ]; then
    echo "Invalid virtual environment at $venv; inspect it before retrying." >&2
    exit 1
fi
. "$venv/bin/activate"
if [ "$#" -eq 1 ]; then
    mkdir -p -- "$1"
    output=$(CDPATH= cd -- "$1" && pwd)
else
    output=$(mktemp -d "${TMPDIR:-/tmp}/sdf-downloader-example.XXXXXXXX")
fi
"$venv/bin/python" "$root/downloader.py" "$root/examples/sample-full.csv" -o "$output/full"
"$venv/bin/python" "$root/downloader.py" "$root/examples/sample-mixed.csv" -o "$output/mixed" --result-selection first
printf 'Example output: %s\n' "$output"
