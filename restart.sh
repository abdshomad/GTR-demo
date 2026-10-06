#!/usr/bin/env bash
# Re-run GTR inference (stop is a no-op: nothing persistent to tear down).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
exec "$SCRIPT_DIR/run.sh" "$@"
