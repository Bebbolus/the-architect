#!/usr/bin/env bash
# sync.sh — Single source of truth -> all harness targets.
#
# Source of truth: ./SKILL.md (this repository = Bebbolus/the-architect)
# Run from the repo root:  ./scripts/sync.sh
#
# Idempotent. Three steps:
#   1. Regenerate ARCHITECT_UNIVERSAL.md from SKILL.md (frontmatter stripped).
#   2. Copy SKILL.md to every registered harness target that exists on disk.
#   3. Copy templates/ next to it (the skill references templates/commands and
#      templates/scripts; without them those references dangle).
#
# No dependencies.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/SKILL.md"
TPL="$ROOT/templates"

[ -f "$SRC" ] || { echo "FATAL: source not found: $SRC"; exit 1; }

# --- 1. Regenerate the agnostic flat document -------------------------------
UNIVERSAL="$ROOT/ARCHITECT_UNIVERSAL.md"
{
  printf '# ARCHITECT UNIVERSAL: Universal Autonomous Context Engine (SEED v3.2)\n\n'
  printf '> Auto-generated from SKILL.md by scripts/sync.sh. Do not edit by hand.\n\n'
  awk 'BEGIN{fm=0} /^---$/{fm++; next} fm>=2{print}' "$SRC"
} > "$UNIVERSAL"
echo "generated: ARCHITECT_UNIVERSAL.md"

# --- 2. Propagate to harness targets ----------------------------------------
TARGETS=(
  "$HOME/Developer/WD/MASTER/.opencode/skills/the-architect"
  "$HOME/.claude/skills/the-architect"
)

for dir in "${TARGETS[@]}"; do
  if [ -d "$dir" ]; then
    if diff -q "$SRC" "$dir/SKILL.md" >/dev/null 2>&1; then
      echo "ok      : $dir/SKILL.md (already in sync)"
    else
      cp "$SRC" "$dir/SKILL.md"
      echo "updated : $dir/SKILL.md"
    fi
    # propagate templates so the SKILL.md references resolve
    if [ -d "$TPL" ]; then
      mkdir -p "$dir/templates"
      rsync -a --delete "$TPL/" "$dir/templates/" >/dev/null 2>&1 || cp -R "$TPL/." "$dir/templates/"
      echo "synced  : $dir/templates/"
    fi
  else
    echo "skip    : $dir (not present)"
  fi
done

echo "sync complete."
