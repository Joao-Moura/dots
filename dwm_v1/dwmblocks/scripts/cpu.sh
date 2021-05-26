#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

declare -r cpu_usage=$(mpstat | grep 'all' | awk -F' ' '{ gsub(",", ".", $NF); print 100 - $NF }')

echo -n "${cpu_usage}%"
