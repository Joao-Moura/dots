#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

declare -r datetime=$(date '+%d %b %H:%M%p')

echo -n "${datetime}"
