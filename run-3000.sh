#!/usr/bin/env bash
# Start entrypoint (wrapper-convention name). GTR inference is one-shot, not a
# server, so there is no PORT to bind — this delegates to ./run.sh.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
exec "$SCRIPT_DIR/run.sh" "$@"
