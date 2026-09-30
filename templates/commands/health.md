---
description: Report the current health and shape of the workspace.
---

Report workspace health. Read-only.

1. Run `scripts/health_check.sh` if present and include its output.
2. Report: total notes, orphan notes, broken links, unresolved contradictions,
   and the last-run date of each scheduled operative from `.state/schedule.json`.
3. Give one line of actionable advice if anything is overdue or broken.

Do not modify any file.
