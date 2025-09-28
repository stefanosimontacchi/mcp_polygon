#!/bin/sh
set -e

# ===== Config per Cloud Run =====
# Cloud Run imposta PORT; alcuni server MCP leggono MCP_HTTP_*.
export MCP_TRANSPORT="${MCP_TRANSPORT:-streamable-http}"
export PORT="${PORT:-8080}"
export MCP_HTTP_HOST="0.0.0.0"
export MCP_HTTP_PORT="${PORT}"
export PYTHONUNBUFFERED=1

# Avvio: preferisci uv (installato nel Dockerfile), fallback su python
if command -v uv >/dev/null 2>&1; then
  exec uv run entrypoint.py
elif command -v python >/dev/null 2>&1; then
  exec python entrypoint.py
else
  echo "❌ Né 'uv' né 'python' trovati nel PATH" >&2
  exit 1
fi
