#!/usr/bin/env bash
# Run inside the pod as docker_start_cmd; env vars come from RunPod (see main.tf).
set -euo pipefail
if ! command -v git >/dev/null 2>&1; then
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -qq && apt-get install -y -qq git curl ca-certificates
fi
cd /workspace
: "${SWAP_REPO_URL:?SWAP_REPO_URL must be set (git URL with remote-swap-server)}"
: "${SWAP_SERVICE_API_KEY:?SWAP_SERVICE_API_KEY must be set}"
SUBPATH="${SWAP_REPO_SUBPATH:-Deep-Live-Cam/remote-swap-server}"
rm -rf dlc-src
git clone --depth 1 "$SWAP_REPO_URL" dlc-src
cd "dlc-src/${SUBPATH}"
exec bash runpod_bootstrap.sh
