#!/bin/bash
# Fill the plugin with the sources it ships: the MCP proxy and the letapis skill.
#
# A symlinked destination is refused. rsync writes THROUGH a symlinked directory,
# so --delete empties the real tree behind the link and still reports success —
# and those sources do not live in this repository to be restored from.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_PROXY="${LETAPIS_PROXY_SRC:-$HOME/Documents/dev_ai/rag/letapis/letapis-mcp}"
SRC_SKILL="${LETAPIS_SKILL_SRC:-$HOME/Documents/dev_ai/rag/letapis/github/letapis-core/skills/letapis}"

EXCLUDES=(
  --exclude '.git' --exclude '.venv'
  --exclude '__pycache__' --exclude '*.pyc'
  --exclude '.pytest_cache' --exclude '.ruff_cache' --exclude '.mypy_cache'
  --exclude '.DS_Store'
)

sync_one() {
  local src="$1" dst="$2"
  [ -d "$src" ] || { echo "sync-sources: source is not a directory: $src" >&2; exit 1; }
  if [ -L "$dst" ]; then
    echo "sync-sources: refusing — $dst is a symlink to $(readlink "$dst")," >&2
    echo "  and rsync would write through it into that working tree. Remove the link first." >&2
    exit 1
  fi
  mkdir -p "$dst"
  rsync -a --delete "${EXCLUDES[@]}" "$src/" "$dst/"
  echo "sync-sources: $(basename "$dst") <- $src"
}

sync_one "$SRC_PROXY" "$ROOT/letapis-mcp"
sync_one "$SRC_SKILL" "$ROOT/skills/letapis"
