#!/bin/bash
# SessionStart: ask the head to recall before it acts.
#
# The hook asks, the head calls: the engine address belongs to .mcp.json, and a
# copy here would answer a recipient whose engine sits elsewhere with silence.
# Recency comes from the window — the memory tool ranks by similarity, not by
# date — so keep DAYS small.
set -uo pipefail

DAYS="${LETAPIS_SESSION_MEMORY_DAYS:-3}"
LIMIT="${LETAPIS_SESSION_MEMORY_LIMIT:-3}"

cat > /dev/null   # the hook payload is not read

back=$(( DAYS - 1 ))
from=$(date -v-"${back}"d +%F 2>/dev/null || date -d "${back} days ago" +%F 2>/dev/null) || exit 0
[ -n "$from" ] || exit 0

command -v jq >/dev/null 2>&1 || exit 0

read -r -d '' TEXT <<EOF || true
Recall before you act.

Your first action in this session is one call to the letapis memory tool
\`ena_get_context\` with \`date_from: "${from}"\` and \`limit: ${LIMIT}\`, and a \`query\` in prose
asking what was recently worked on, decided and stumbled over. That answer is what happened
just before this session — read it and carry it into your work.

One call, at the start, and no more: this is not a standing instruction to keep querying memory.
If the tool is unavailable or the answer is empty, continue without it and do not look for
another route to the engine.
EOF

jq -n --arg t "$TEXT" '{
  hookSpecificOutput: {
    hookEventName: "SessionStart",
    additionalContext: $t
  }
}'
exit 0
