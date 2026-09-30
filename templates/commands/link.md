---
description: Find and add missing connections between notes.
---

Find missing links in the knowledge base.

Scope: $ARGUMENTS (default: all of `3_KNOWLEDGE/`).

Act as the MAKER archetype, link pass only:
1. For each note, look for related concepts not yet linked.
2. Add bidirectional wikilinks `[[...]]` where a real relationship exists.
3. Do not invent relationships. If unsure, skip.
4. Report notes that gained links and notes still orphaned.

This is a prepare pass: propose the link changes first; apply only on approval.
