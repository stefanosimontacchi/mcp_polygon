#!/bin/sh
set -e

# Forziamo il trasporto HTTP per MCP
export MCP_TRANSPORT="${MCP_TRANSPORT:-streamable-http}"

# Host/Port corretti per Cloud Run
HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-8080}"

# Preferisci uv se c'è; altrimenti usa python
if command -v uv >/dev/null 2>&1; then
  exec uv run entrypoint.py --host "$HOST" --port "$PORT"
elif command -v python >/dev/null 2>&1; then
  exec python entrypoint.py --host "$HOST" --port "$PORT"
else
  echo "❌ Né 'uv' né 'python' trovati nel PATH" >&2
  exit 1
fi
