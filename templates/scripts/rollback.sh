#!/usr/bin/env bash
# rollback.sh — undo the last write pass.
#
# Usage: scripts/rollback.sh [N]
#   N = how many commits to undo (default: 1).
#
# Requires a git repository. Uses `git revert` so history is preserved
# (safe for shared or versioned knowledge bases). Falls back to `git reset
# --hard HEAD~N` only when the commit was never pushed and --hard is passed.
set -euo pipefail

N="${1:-1}"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "FATAL: not a git repository; rollback needs version control." >&2
  exit 1
fi

echo "== last $N commit(s) =="
git --no-pager log --oneline -n "$N"
echo
read -r -p "Revert these $N commit(s)? [y/N] " ans
case "$ans" in
  y|Y) ;;
  *) echo "aborted."; exit 0 ;;
esac

git revert --no-edit HEAD~"$((N-1))"..HEAD
echo "done. history preserved."
