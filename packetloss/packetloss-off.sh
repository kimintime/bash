#!/usr/bin/env bash
set -euo pipefail

echo "Disabling packet filter and flushing dummynet rules..."
sudo pfctl -d
sudo dnctl flush
echo "Packet loss disabled."
