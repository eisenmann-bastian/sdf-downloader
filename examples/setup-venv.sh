#!/bin/sh
set -eu
root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
if [ "$#" -gt 1 ]; then
    echo "Usage: $0 [environment-directory]" >&2
    exit 2
fi
env_dir=${1-"$root/.venv"}
if [ -z "$env_dir" ] || [ -e "$env_dir" ] || [ -L "$env_dir" ]; then
    echo "Environment path must be nonempty and not already exist: $env_dir" >&2
    exit 1
fi
python=${PYTHON:-python3}
"$python" -c 'import sys; sys.exit("Python 3.10 or later is required.") if sys.version_info < (3, 10) else None'
"$python" -m venv "$env_dir"
env_dir=$(CDPATH= cd -- "$env_dir" && pwd)
"$env_dir/bin/python" -m pip install -e "$root"
printf 'Environment created: %s\n' "$env_dir"
printf 'Activate it with: . "%s/bin/activate"\n' "$env_dir"
