#!/usr/bin/env bash
# health_check.sh — quick structural health report of a workspace.
#
# Usage: scripts/health_check.sh [knowledge-dir]
# Default knowledge dir: 3_KNOWLEDGE (falls back to any *_KNOWLEDGE* folder).
# Read-only. No dependencies.
set -euo pipefail

KB="${1:-3_KNOWLEDGE}"
if [ ! -d "$KB" ]; then
  KB="$(find . -maxdepth 1 -type d -iname '*knowledge*' | head -1 || true)"
fi

if [ -z "$KB" ] || [ ! -d "$KB" ]; then
  echo "no knowledge directory found."
  exit 0
fi

notes="$(find "$KB" -name '*.md' | wc -l | tr -d ' ')"
links="$(grep -rhoE '\[\[[^]]+\]\]' "$KB" 2>/dev/null | wc -l | tr -d ' ')"
orphans="$(grep -rLE '\[\[[^]]+\]\]' "$KB" --include='*.md' 2>/dev/null | wc -l | tr -d ' ')"
contradictions="0"
[ -f "$KB/contradictions.md" ] && contradictions="$(grep -c 'OPEN' "$KB/contradictions.md" 2>/dev/null || echo 0)"

echo "== workspace health =="
echo "knowledge dir        : $KB"
echo "notes                : $notes"
echo "wikilinks            : $links"
echo "orphan notes         : $orphans"
echo "open contradictions  : $contradictions"

if [ -f .state/schedule.json ]; then
  echo
  echo "== scheduled operatives (last run) =="
  cat .state/schedule.json
fi
