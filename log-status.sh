#!/usr/bin/env bash
# Show GTR demo status: runtime, weights, and recent inference outputs.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
cd "$SCRIPT_DIR"

# shellcheck disable=SC1091
[ -f .env ] && set -a && . ./.env && set +a
OUTPUT="${OUTPUT:-outputs/inference/result.jpg}"

echo "=== runtime ==="
if [ -x .venv/bin/python ]; then
  uv run --no-project python -c "import torch; print('torch', torch.__version__, '| cuda_available', torch.cuda.is_available())" 2>&1 || echo ".venv broken — re-run ./install.sh"
else
  echo "MISSING .venv — run ./install.sh"
fi

echo "=== weights ==="
ls -lh weights/det/*.pth 2>/dev/null || echo "no weights — run ./install.sh"

echo "=== outputs ==="
OUT_LIST="$(find outputs/inference -maxdepth 1 -type f -printf '%T+ %p\n' 2>/dev/null | sort -r | head -10 || true)"
if [ -n "$OUT_LIST" ]; then echo "$OUT_LIST"; else echo "no outputs yet — run ./run-3000.sh"; fi
if [ -f "$OUTPUT" ]; then echo "latest default output: $OUTPUT"; fi
exit 0
