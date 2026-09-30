// the-architect-guard.js — deterministic guardrails for The Architect (SEED v3.2).
//
// Hook-First enforcement: rules that are mechanically checkable live here, not in
// prompt text. Zero dependencies.
//
//   1. SECRETS GATE  - always on. Refuse a write/edit whose content looks like a
//                      committed secret (key, token, private key, password).
//   2. CONFINEMENT   - only inside a generated Architect workspace (detected by a
//                      `0_SYSTEM/CONTEXT.md` file at the project root). Refuse a
//                      write/edit to a path outside the project directory (C4).
//                      Outside generated workspaces (e.g. a normal repo), confinement
//                      is NOT enforced, so cross-directory tooling keeps working.
//
// Destructive shell commands are gated natively by `permission.bash` in opencode.jsonc,
// so they are intentionally NOT duplicated here.
//
// Loaded automatically from .opencode/plugins/. No config entry needed.

import { existsSync } from "node:fs";
import { join } from "node:path";

const SECRET_PATTERNS = [
  /AKIA[0-9A-Z]{16}/,                       // AWS access key id
  /ghp_[A-Za-z0-9]{20,}/,                   // GitHub personal token
  /sk-[A-Za-z0-9]{20,}/,                    // OpenAI-style key
  /-----BEGIN [A-Z ]*PRIVATE KEY-----/,     // PEM private key
  /(api[_-]?key|secret|password|token)\s*[:=]\s*["'][^"']{12,}["']/i,
];

function looksLikeSecret(text) {
  if (!text) return null;
  for (const re of SECRET_PATTERNS) {
    const m = text.match(re);
    if (m) return m[0].slice(0, 12) + "...";
  }
  return null;
}

function outsideProject(filePath, directory) {
  if (!filePath || !directory) return false;
  if (filePath.startsWith("/")) return !filePath.startsWith(directory);
  return filePath.includes("../");
}

export default async ({ directory }) => {
  const isGeneratedWorkspace =
    directory && existsSync(join(directory, "0_SYSTEM", "CONTEXT.md"));

  return {
    "tool.execute.before": async (input, output) => {
      const tool = input?.tool;
      if (tool !== "write" && tool !== "edit") return;

      const args = output?.args ?? {};
      const filePath = args.filePath ?? args.path;
      const content = args.content ?? args.newString ?? "";

      const hit = looksLikeSecret(content);
      if (hit) {
        throw new Error(
          `[the-architect-guard] Blocked: ${filePath} looks like it contains a secret (${hit}). ` +
            `Remove it or write it to a gitignored file.`
        );
      }

      if (isGeneratedWorkspace && outsideProject(filePath, directory)) {
        throw new Error(
          `[the-architect-guard] Blocked: ${filePath} is outside the workspace (${directory}). ` +
            `Territorial confinement (C4) forbids writing outside a generated factory.`
        );
      }
    },
  };
};
