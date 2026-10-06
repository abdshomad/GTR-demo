#!/usr/bin/env bash
# GTR inference runs one-shot in the foreground — there is no daemon to stop.
set -euo pipefail
echo "GTR inference is one-shot; nothing running to stop."
exit 0
