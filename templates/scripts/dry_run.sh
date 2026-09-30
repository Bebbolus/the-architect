#!/usr/bin/env bash
# dry_run.sh — preview what a change would touch, without writing anything.
#
# Usage: scripts/dry_run.sh <path-or-pattern> [more...]
# Prints the files that match, their line counts, and a diff against the last
# git commit. Read-only: never modifies the working tree.
set -euo pipefail

if [ "$#" -eq 0 ]; then
  echo "usage: dry_run.sh <path-or-pattern> [more...]" >&2
  exit 2
fi

for target in "$@"; do
  echo "== $target =="
  find . -path ./.git -prune -o -name "$target" -print 2>/dev/null || true
done

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo
  echo "== uncommitted diff (preview) =="
  git --no-pager diff --stat -- "$@"
else
  echo "(not a git repository: no diff available)"
fi
