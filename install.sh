#!/usr/bin/env bash
# Install the GTR demo runtime: uv-managed venv, Python deps, default weights.
# Idempotent — safe to re-run. Never touches GTR/ (submodule, read-only).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
cd "$SCRIPT_DIR"

log() { echo "[$(date '+%F %T')] $*"; }
error() { log "ERROR: $*" >&2; exit 1; }

command -v uv >/dev/null 2>&1 || error "uv not found (https://docs.astral.sh/uv/)"
command -v curl >/dev/null 2>&1 || error "curl not found"

# Reference env per GTR README: Python 3.11, CUDA 12.8, torch 2.11.0 (see GTR/requirements.txt).
if [ ! -x .venv/bin/python ]; then
  log "creating .venv (python 3.11)..."
  uv venv --python 3.11 || error "uv venv failed"
else
  log ".venv exists, reusing"
fi

log "installing GTR dependencies..."
uv pip install --python .venv/bin/python -r GTR/requirements.txt || error "dependency install failed"

# Default weights: smallest released detector (GTR-S, COCO). Matches .env defaults.
mkdir -p weights/det
if [ ! -s weights/det/gtr_s_coco.pth ]; then
  log "downloading gtr_s_coco.pth..."
  curl -fL -o weights/det/gtr_s_coco.pth \
    https://huggingface.co/Phoenix8125/GTR/resolve/main/det/gtr_s_coco.pth \
    || error "weights download failed"
else
  log "weights present, skipping download"
fi

log "install complete — next: ./run-3000.sh"
