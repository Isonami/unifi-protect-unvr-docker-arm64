#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(dirname "$0")"
cd "$SCRIPT_DIR"

docker build -f firmware-base.Dockerfile -t unvr-firmware-base --pull .
docker build -f firmware.Dockerfile --no-cache -t unvr-firmware \
    --build-arg "FW_URL=${FW_URL:-}" --build-arg "ALL_DEBS=${ALL_DEBS:-}" .
if [ -f firmware/version ]; then
    rm -r firmware/*
fi
docker build -f firmware-copy.Dockerfile --output firmware .
