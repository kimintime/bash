#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <packet-loss-percentage>" >&2
    echo "Example: $0 10   # simulate 10% packet loss" >&2
    exit 1
fi

pct=$1

if ! [[ $pct =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Error: '$pct' is not a valid number" >&2
    exit 1
fi

if awk "BEGIN { exit !($pct < 0 || $pct > 100) }"; then
    echo "Error: percentage must be between 0 and 100" >&2
    exit 1
fi

rate=$(awk "BEGIN { printf \"%.4f\", $pct / 100 }")

echo "Enabling ${pct}% packet loss (plr=${rate})..."
sudo dnctl pipe 1 config plr "$rate"
echo "dummynet out proto {tcp,udp} from any to any pipe 1" | sudo pfctl -f -
sudo pfctl -e
echo "Packet loss enabled. Run packetloss-off.sh to disable."
