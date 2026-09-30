---
description: Ingest new material from the inbox into the knowledge base.
---

Ingest new material into the knowledge base.

Scope: $ARGUMENTS (default: everything waiting in `1_INBOX/`).

Act as the MAKER archetype. For each source:
1. Read it from the inbox.
2. Extract atomic concepts (MECE multi-target splitting; no compound titles).
3. Write one definition-first note per concept into `3_KNOWLEDGE/drafts/`.
4. Add YAML frontmatter and at least one bidirectional wikilink `[[...]]`.
5. Leave orphan notes (no valid link) in `drafts/`; do not promote them.

Do not touch files outside the inbox and `3_KNOWLEDGE/`. Follow clauses C1-C3.
