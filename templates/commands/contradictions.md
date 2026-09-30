---
description: List unresolved contradictions recorded in the knowledge base.
---

List unresolved contradictions.

Scope: $ARGUMENTS (default: all of `3_KNOWLEDGE/`).

Read `3_KNOWLEDGE/contradictions.md` if it exists. Then act as the CHECKER archetype:
1. Scan notes for claims that conflict with each other.
2. For each conflict, report: the two sources, the conflicting claims, and which is
   better evidenced (with `[File:Line]` citations).
3. Append any newly found contradiction to `contradictions.md` as `OPEN`.
4. Never silently resolve a contradiction. Only the user closes one.
