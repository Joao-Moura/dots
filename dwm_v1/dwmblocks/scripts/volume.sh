#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

declare -r volume=$(echo $(amixer get Master 2> /dev/null || amixer get Speaker 2> /dev/null) | tail -1 | sed -r 's/.*\[([0-9%]{2,4})\].*/\1/')

echo -n "$volume"
