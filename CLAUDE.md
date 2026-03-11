# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Repository Purpose

**prompt-dev** is a Claude Code plugin — a meta-toolkit that provides the tools to build tools for Claude Code. It scaffolds plugin components (agents, skills, commands, hooks) through specialized creator agents (with skill-based self-review) and reference skills.

## Repository Structure

```
prompt-dev/
├── .claude-plugin/
│   ├── plugin.json              # Plugin manifest
│   └── marketplace.json         # Marketplace distribution config
├── agents/                      # 5 agents
│   ├── agent-creator.md         # Generates agent configs (self-reviews via agent-development skill)
│   ├── command-creator.md       # Generates command files (self-reviews via command-development skill)
│   ├── hook-creator.md          # Generates hook configs and scripts (self-reviews via hook-development skill)
│   ├── skill-creator.md         # Generates skills (self-reviews via skill-development skill)
│   └── plugin-validator.md      # Validates entire plugin structure
├── skills/                      # 7 reference skills
│   ├── agent-development/       # Agent patterns, frontmatter, triggering
│   ├── command-development/     # Command structure, arguments, tools
│   ├── hook-development/        # Hook events, matchers, security
│   ├── mcp-integration/         # MCP server types, authentication
│   ├── plugin-settings/         # .local.md config pattern
│   ├── plugin-structure/        # Directory layout, manifests, auto-discovery
│   └── skill-development/       # Progressive disclosure, trigger phrases
├── CLAUDE.md
└── README.md
```

### Component Architecture

Each component type has a complete toolchain:
- **Creator agent** for AI-assisted generation (preloads development skill for self-review)
- **Reference skill** for domain knowledge and quality standards

## Core Principles

### Progressive Disclosure

Skills use three-tier information architecture:
1. **Metadata** (always loaded): Description with trigger phrases in frontmatter
2. **Core content** (when triggered): SKILL.md body (~1,500-2,000 words)
3. **Resources** (as needed): `references/`, `examples/`, `scripts/` subdirectories

### Portability

Always use `${CLAUDE_PLUGIN_ROOT}` for intra-plugin paths. Never hardcode absolute paths.

### Auto-Discovery

Claude Code discovers components automatically:
- `agents/*.md` — subagents
- `skills/*/SKILL.md` — skills
- `hooks/hooks.json` — hooks
- `.mcp.json` — MCP servers

### Naming

kebab-case everywhere: files, directories, identifiers. Avoid generic terms ("helper", "utils").

## Component Patterns

### Agents

```yaml
---
name: identifier         # kebab-case, 3-50 chars
description: Use this agent when... # with 2-4 <example> blocks
model: inherit           # inherit/sonnet/opus/haiku
color: green             # blue/cyan/green/yellow/red/magenta
tools: ["Read", "Write"] # minimal set needed
---

[System prompt: 500-3,000 words with role, process, output format, edge cases]
```

### Skills

```yaml
---
name: Skill Name
description: This skill should be used when the user asks to "phrase 1", "phrase 2", mentions "concept", or needs guidance on [topic].
version: 0.1.0
---

[Body: imperative form, 1,500-2,000 words. Never second person.]
```

### Commands

```yaml
---
description: Brief purpose (< 60 chars)
argument-hint: [arg1] [arg2]
allowed-tools: ["Read", "Write", "Bash"]  # least privilege
---

[Instructions FOR Claude, not documentation TO users]
```

### Hooks

Plugin format (`hooks/hooks.json`):
```json
{
  "description": "Hook purpose",
  "hooks": {
    "PreToolUse": [{
      "matcher": "Write|Edit",
      "hooks": [{
        "type": "command",
        "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/scripts/validate.sh",
        "timeout": 30
      }]
    }]
  }
}
```

Hook types: `command` (fast/deterministic), `prompt` (context-aware), `agent` (complex with tool access).

Events: PreToolUse, PostToolUse, PostToolUseFailure, UserPromptSubmit, PermissionRequest, Stop, SubagentStop, SubagentStart, SessionStart, SessionEnd, PreCompact, Notification, TeammateIdle, TaskCompleted.

## Workflows

### Create a component

Trigger creator agents directly: "Create an agent that validates configurations"

### Validate

- **Plugin structure**: Use plugin-validator agent
- **Component quality**: Creator agents self-review using preloaded development skills
- **Agent structure**: `skills/agent-development/scripts/validate-agent.sh agents/[name].md`
- **Hook schema**: `skills/hook-development/scripts/validate-hook-schema.sh hooks/hooks.json`

### Test locally

```bash
cc --plugin-dir /path/to/prompt-dev
claude --debug  # see component loading and hook execution
```

## Quality Standards

- **Security**: Input validation in hooks, HTTPS for MCP, env vars for credentials, least privilege tools
- **Portability**: `${CLAUDE_PLUGIN_ROOT}` for all paths, no hardcoded absolutes
- **Naming**: kebab-case, descriptive, no generic terms
- **Progressive disclosure**: Lean SKILL.md, details in references/
