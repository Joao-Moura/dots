#!/bin/bash

# Shows how much data has been received (RX) or transmitted (TX)
# since the previous time this script ran.

rxcache=${TMPDIR:-/tmp}/dwmb.network.rx
txcache=${TMPDIR:-/tmp}/dwmb.network.tx

# Sum all byte values from all interfaces
rxnow=0
txnow=0
for line in /sys/class/net/[ew]*/; do
    rxnow="$((rxnow + $(cat -- "$line/statistics/rx_bytes")))"
    txnow="$((txnow + $(cat -- "$line/statistics/tx_bytes")))"
done

# Get stored byte values
[ -f "$rxcache" ] && rxprev="$(cat -- "$rxcache")" || rxprev=0
[ -f "$txcache" ] && txprev="$(cat -- "$txcache")" || txprev=0

# Cache new values
printf "%d\n" "$rxnow" >"$rxcache"
chmod 600 -- "$rxcache"
printf "%d\n" "$txnow" >"$txcache"
chmod 600 -- "$txcache"

# Calculate difference
rxnew="$((rxnow - rxprev))"
txnew="$((txnow - txprev))"

# Final output
printf "RX: $rxnew | TX: $txnew"
