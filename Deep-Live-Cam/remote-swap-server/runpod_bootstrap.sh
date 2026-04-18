#!/usr/bin/env bash
# On a RunPod GPU pod (PyTorch+CUDA template), from workspace:
#   git clone <your fork with Deep-Live-Cam> dlc && cd dlc/remote-swap-server
#   export SWAP_SERVICE_API_KEY='your-secret'
#   bash runpod_bootstrap.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
MODEL_DIR="${MODEL_DIR:-/workspace/models}"
mkdir -p "$MODEL_DIR"
MODEL="${INSWAPPER_MODEL_PATH:-$MODEL_DIR/inswapper_128.onnx}"
if [[ ! -f "$MODEL" ]]; then
  echo "Downloading inswapper to $MODEL ..."
  curl -fL -o "$MODEL" "https://huggingface.co/hacksider/deep-live-cam/resolve/main/inswapper_128.onnx?download=true"
fi
export INSWAPPER_MODEL_PATH="$MODEL"
if [[ -z "${SWAP_SERVICE_API_KEY:-}" ]]; then
  echo "Set SWAP_SERVICE_API_KEY before starting (same value as DLC_REMOTE_SWAP_API_KEY on your Mac)."
  exit 1
fi
python3 -m pip install -q -r "$ROOT/requirements.txt"
exec python3 -m uvicorn app:app --host 0.0.0.0 --port "${PORT:-8000}"
