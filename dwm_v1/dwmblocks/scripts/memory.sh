#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

declare -r memory_usage=$(free -h | awk '/Mem/ { print $3"/"$2 }' | sed s/i//g)

echo -n "${memory_usage}"
