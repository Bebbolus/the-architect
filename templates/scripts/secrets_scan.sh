#!/usr/bin/env bash
# secrets_scan.sh — scan the workspace for accidentally committed secrets.
#
# Usage: scripts/secrets_scan.sh [dir]
# Exits 1 if anything suspicious is found, 0 if clean.
# Pure grep; no network, no dependencies.
set -euo pipefail

DIR="${1:-.}"
PATTERNS='(api[_-]?key|secret|password|passwd|token|bearer|private[_-]?key|BEGIN [A-Z ]*PRIVATE KEY|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,}|sk-[A-Za-z0-9]{20,})'

hits="$(grep -rInE "$PATTERNS" "$DIR" \
  --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.venv \
  --exclude='*.lock' --exclude='*.min.js' 2>/dev/null || true)"

if [ -n "$hits" ]; then
  echo "POTENTIAL SECRETS FOUND:"
  echo "$hits"
  exit 1
fi
echo "clean: no obvious secrets in $DIR"
