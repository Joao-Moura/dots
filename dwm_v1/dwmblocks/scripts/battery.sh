#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

declare -r battery=$(acpi -b | cut -d',' -f2 | tr -d ' ')

echo -n "${battery}"
