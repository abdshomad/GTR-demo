#!/usr/bin/env bash
# One-shot GTR inference on a single image (foreground, not a daemon).
# Usage: [CONFIG=...] [WEIGHTS=...] [INPUT=...] [OUTPUT=...] [DEVICE=...] [THRH=...] ./run.sh
# Defaults live in .env; env vars override.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
cd "$SCRIPT_DIR"

log() { echo "[$(date '+%F %T')] $*"; }
error() { log "ERROR: $*" >&2; exit 1; }

# shellcheck disable=SC1091
[ -f .env ] && set -a && . ./.env && set +a

CONFIG="${CONFIG:-GTR/configs/det/coco_finetune/gtr_s.yml}"
WEIGHTS="${WEIGHTS:-weights/det/gtr_s_coco.pth}"
INPUT="${INPUT:-GTR/assets/teaser.png}"
OUTPUT="${OUTPUT:-outputs/inference/result.jpg}"
DEVICE="${DEVICE:-cuda:0}"
THRH="${THRH:-0.45}"

[ -x .venv/bin/python ] || error "missing .venv — run ./install.sh first"
[ -f "$CONFIG" ] || error "config not found: $CONFIG"
[ -f "$WEIGHTS" ] || error "weights not found: $WEIGHTS — run ./install.sh first"
[ -f "$INPUT" ] || error "input image not found: $INPUT"
mkdir -p "$(dirname "$OUTPUT")"

log "config=$CONFIG weights=$WEIGHTS input=$INPUT device=$DEVICE thrh=$THRH"
uv run --no-project python GTR/tools/inference/torch_inf.py \
  -c "$CONFIG" -r "$WEIGHTS" -i "$INPUT" -o "$OUTPUT" -d "$DEVICE" -t "$THRH" \
  || error "inference failed"
log "saved $OUTPUT"
