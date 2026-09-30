# 🏛️ The Architect: Universal Autonomous Context Engine

[![Standard: Universal Skill](https://img.shields.io/badge/Standard-Universal%20Skill-blue.svg)](https://github.com/Bebbolus/the-architect)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Version](https://img.shields.io/badge/SEED-v3.1-green.svg)](https://github.com/Bebbolus/the-architect)
[![Compatible: DSH · Claude Code · Cursor · Antigravity · Goose · OpenCode](https://img.shields.io/badge/Compatibility-Universal%20Harnesses-purple.svg)](https://github.com/Bebbolus/the-architect)

> **This is the single source of truth.** All other Architect repositories are archived. Fork, copy or sync from here.

**The Architect** is an autonomous context engine and meta-orchestrator for agentic IDEs and LLM harnesses. Operating under the **Model Workspace Protocol (MWP)** and the **Interpretable Context Methodology (ICM)**, it treats the LLM as a state compiler rather than a conversational chatbot.

It does not solve domain tasks in chat. It interviews the user, designs the directory topology, and compiles the operative contracts, hooks and archetypes that execute with autonomy, zero token bloat and zero hallucination.

---

## 📂 Repository Layout

| File | Purpose |
|---|---|
| `SKILL.md` | The canonical skill (harness-native, YAML frontmatter). **Edit this.** |
| `ARCHITECT_UNIVERSAL.md` | Platform-agnostic flat document. **Auto-generated** from `SKILL.md`. |
| `scripts/sync.sh` | Regenerates the universal doc and propagates `SKILL.md` to every harness. |

---

## ⚡ Core Paradigms (v3.1)

1. **Prompt-as-Architecture**: self-contained Markdown. Zero databases, zero runtime deps.
2. **Three Dogmas, not six**: (1) MWP / Stateless Reducer, (2) Hook-First Enforcement, (3) Universal Triage Gate.
3. **Hook-First**: *"A rule entrusted to model discipline will fail; a rule enforced by software holds."* Mechanical rules (confinement, destructive-command gates, output linting) are harness hooks, never prompt text.
4. **Three core clauses (C1–C3)**: Routing Fallback, Handoff State Protocol, Code-as-Action & Active Oblivion. Confinement/retry/evidence-grounding are hooks or domain adapters.
5. **Four Generative Archetypes (Anti-Context Bloat)**:
   - **Maker (Curator)**: definition-first extraction, MECE multi-target splitting, atomic 1:1 Obsidian backlinks.
   - **Checker (Auditor & Critic)**: 4-front adversarial stress-testing + calibration.
   - **Recon (Explorer)**: hypothesis-driven search with explicit execution traces.
   - **Coder (Builder)**: intent-gated surgical engineering with test-first verification.
6. **Write Discipline**: only Maker and Coder write; Checker and Recon are read-only. Bulk/destructive writes go through *prepare → approve → materialize*.

---

## 🚀 How to Execute

### Option A: As an Agentic Skill
```bash
# Claude Code (global)
mkdir -p ~/.claude/skills/the-architect && cp SKILL.md ~/.claude/skills/the-architect/
# OpenCode
cp SKILL.md .opencode/skills/the-architect/SKILL.md
```
Then invoke `/the-architect`.

### Option B: As a System Prompt or Initial Instruction
Feed `SKILL.md` (or the agnostic `ARCHITECT_UNIVERSAL.md`) as the first instruction in a clean workspace:
```text
Read SKILL.md and execute State 0 (Triage).
```

---

## 🔄 Keeping Harnesses in Sync

`SKILL.md` here is the only file you edit. Run:

```bash
./scripts/sync.sh
```

It regenerates `ARCHITECT_UNIVERSAL.md` and copies `SKILL.md` to every registered harness target that exists on disk (OpenCode, Claude Code, and local clones). Idempotent and dependency-free.

---

## 🧭 Workflow Lifecycle

```
[Start] ──► State 0: Reconnaissance (Greenfield vs Brownfield, host detection)
               │
               ▼
            State 1: Triage Depth (Fast 3-question vs Deep Socratic)
               │
               ▼
            Scaffold topology (Pipeline | Knowledge Bundle | Record Library)
               │
               ▼
            Derive operatives from 4 Archetypes + embed C1–C3
               │
               ▼
            Rule of Closure ──► Factory Operational
```

---

## 📜 License
MIT © Bebbolus
