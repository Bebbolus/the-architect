---
description: Audit the knowledge base structure and repair what is mechanical.
---

Audit the knowledge base and repair mechanical problems.

Scope: $ARGUMENTS (default: all of `3_KNOWLEDGE/`).

Act as the CHECKER archetype (read-only for content):
1. Check frontmatter against the schema (id, title, type, tags, aliases).
2. Flag notes with compound titles, missing definitions, or no wikilinks.
3. Flag broken `[[links]]` that point to non-existent notes.
4. Repair only mechanical issues (frontmatter fields, whitespace). Never rewrite content.
5. Report: fixed items, flagged items, and items needing a human decision.
