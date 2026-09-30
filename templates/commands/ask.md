---
description: Answer a question using only what is in the knowledge base.
---

Answer the question using ONLY the local knowledge base.

Question: $ARGUMENTS

Act as the RECON archetype (read-only):
1. Search `3_KNOWLEDGE/` for the concepts involved.
2. Cite every claim with `[File:Line]` pointing at a note in this workspace.
3. If the base does not contain the answer, say so and name the gap. Do not invent.

Return: the answer, then a `Sources` list, then `Gaps`.
