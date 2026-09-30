# 🏛️ The Architect

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Compatible: DSH · Claude Code · Cursor · Antigravity · Goose · OpenCode](https://img.shields.io/badge/Compatibility-Universal%20Harnesses-purple.svg)](https://github.com/Bebbolus/the-architect)

**The Architect** is a portable Markdown skill that turns an AI coding agent into a
**workspace architect**. Instead of answering a request directly, it interviews you,
designs the folder structure your task needs, and writes the operating instructions
("contracts") that specialised sub-agents follow to complete the work on their own.

The goal is simple: stop cramming everything into a chat window. Put the context on
disk, in files, where any agent can read it later without you repeating yourself.

---

## The Idea

Most AI work fails for two reasons: the model forgets context between steps, and it
improvises where it should follow a rule. The Architect addresses both.

- **State lives on disk, not in chat.** Every step writes a Markdown or YAML file.
  The next step reads that file and continues. Nothing important depends on the
  conversation still being in the window.
- **Rules are enforced by software, not by asking nicely.** Where a constraint can be
  checked mechanically (don't write outside this folder, confirm before deleting,
  reject an output that breaks the format), The Architect attaches a hook to the host
  harness instead of trusting the model to remember.
- **The work is split into four roles.** A *Maker* writes knowledge notes, a *Checker*
  attacks them adversarially, a *Recon* gathers sources, a *Coder* builds. Only the
  Maker and the Coder are allowed to write; the Checker and Recon are read-only, so a
  bad analysis run cannot damage your files.

---

## What It Produces

Given a task, The Architect scaffolds a working directory. A typical result:

```
your-project/
├── 0_SYSTEM/       project map, decision log, retrospective notes
├── 1_INBOX/        raw material you drop in
├── 2_WORKFLOW/     numbered stages, each with its own instructions + input/output
├── 3_KNOWLEDGE/    a linked Markdown knowledge base (Obsidian-compatible)
└── tmp/            scratch space, emptied after use
```

Each stage folder contains a `CONTEXT.md` that tells the sub-agent exactly what to read,
what to produce, and which rules it must not break. A sub-agent with no memory of your
conversation can open the project root and know what to do.

You choose the shape during setup. Three ready-made forms are offered (a linear pipeline,
a knowledge bundle, a record library), and folder names are yours to change.

---

## The Four Archetypes

| Archetype | Role | Writes? |
|---|---|---|
| **Maker** | Extracts and compiles atomic, definition-first knowledge notes. | Yes |
| **Checker** | Attacks notes and claims for contradictions, hidden assumptions, weak evidence. | No |
| **Recon** | Gathers sources with an explicit search trail and verbatim citations. | No |
| **Coder** | Builds software with small, verified changes. | Yes |

Bulk or destructive changes are never applied in one shot. The agent first *prepares* a
proposed change in `tmp/`, you approve it, then a second pass *materialises* it.

---

## Install

The skill is a single file, `SKILL.md`. Copy it into whichever harness you use:

```bash
# Claude Code (global)
mkdir -p ~/.claude/skills/the-architect
cp SKILL.md ~/.claude/skills/the-architect/

# OpenCode
cp SKILL.md .opencode/skills/the-architect/SKILL.md

# DeepSeek Harness
cp SKILL.md /path/to/dsh/skills/the-architect/SKILL.md
```

Then invoke it in a session:

```text
/the-architect
```

You can also skip the skill system entirely: paste `SKILL.md` (or the flat
`ARCHITECT_UNIVERSAL.md`) as the first instruction in any clean workspace.

---

## Files in This Repository

| File | Purpose |
|---|---|
| `SKILL.md` | The skill itself, in the format harnesses load. This is the file to edit. |
| `ARCHITECT_UNIVERSAL.md` | The same content as a plain document, for harnesses without a skill system. Auto-generated from `SKILL.md`. |
| `scripts/sync.sh` | Regenerates the universal document and copies `SKILL.md` to every harness folder present on your machine. |
| `templates/commands/` | Thin slash commands the Architect copies into a new workspace (ingest, ask, link, lint, contradictions, graph, health, review). |
| `templates/scripts/` | Concrete safety scripts copied into a new workspace (`dry_run`, `rollback`, `secrets_scan`, `health_check`). |

---

## Keeping Copies in Sync

If you use The Architect in more than one harness, edit only `SKILL.md` and run:

```bash
./scripts/sync.sh
```

It rebuilds `ARCHITECT_UNIVERSAL.md` and copies `SKILL.md` to each harness folder it
finds. Running it twice changes nothing. No dependencies.

---

## How a Session Goes

```
Start
  └─> Look around: is this an empty workspace or an existing project?
        └─> Ask how deep you want the setup (three quick questions, or a longer interview)
              └─> Build the folder structure you choose
                    └─> Write the instructions for each stage
                          └─> Final check: every output has a consumer, every rule is in place
                                └─> Ready to run
```

Small, one-off requests skip all of this. If the task is trivial, The Architect just
does it.

---

## License
MIT © Bebbolus
