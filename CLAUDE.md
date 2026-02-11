# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

**Prompt-Dev** components:

- **Agents**: Autonomous subagents that perform specialized tasks
- **Skills**: Auto-activating knowledge modules triggered by context
- **Commands**: Slash commands for user-initiated actions
- **Hooks**: Event-driven automation and validation
- **Plugins**: Complete packages combining multiple components
- **MCP Integration**: Model Context Protocol server configurations

This repository serves as a **meta-toolkit**: it contains the tools to build tools for Claude Code.

## Repository Structure

```
reference/
├── plugin-dev/          # Comprehensive plugin development toolkit
│   ├── skills/         # 7 skills covering all aspects of plugin development
│   ├── agents/         # 3 specialized agents (agent-creator, plugin-validator, skill-reviewer)
│   ├── commands/       # create-plugin workflow command
│   └── README.md       # Full plugin-dev documentation
│
└── hookfy/             # Plugin for creating hooks from conversation analysis
    ├── core/          # Rule engine and config loader (Python)
    ├── hooks/         # Hook implementations
    ├── commands/      # hookify commands (help, list, configure, hookify)
    ├── agents/        # conversation-analyzer agent
    └── examples/      # Example hook configurations
```

## Core Architectural Principles

### 1. Progressive Disclosure

Components use a three-tier information architecture:

1. **Metadata** (always loaded): Concise descriptions with strong trigger phrases
2. **Core content** (when triggered): Essential reference (~1,500-2,000 words)
3. **Resources** (as needed): Detailed guides, examples, scripts in subdirectories

**Apply this pattern** when creating new skills or documentation.

### 2. Component-Based Architecture

Claude Code plugins follow standardized structures:

```
plugin-name/
├── .claude-plugin/plugin.json    # REQUIRED: Manifest at this location
├── commands/                      # Slash commands (.md files)
├── agents/                        # Subagents (.md files with frontmatter)
├── skills/[skill-name]/SKILL.md  # Skills (subdirectories with SKILL.md)
├── hooks/hooks.json              # Event handlers
├── .mcp.json                     # MCP server definitions
└── scripts/                      # Utilities and helpers
```

**Critical**: Directories like `commands/`, `agents/`, `skills/` are at plugin root, NOT inside `.claude-plugin/`.

### 3. Portability via ${CLAUDE_PLUGIN_ROOT}

**Always use** `${CLAUDE_PLUGIN_ROOT}` for intra-plugin path references:

```json
{
  "command": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh"
}
```

**Never use**: Hardcoded absolute paths, relative paths from working directory, or home directory shortcuts.

### 4. Auto-Discovery Mechanism

Claude Code automatically discovers components when plugins load:
- Commands: All `.md` files in `commands/`
- Agents: All `.md` files in `agents/`
- Skills: All `SKILL.md` files in `skills/[subdirectory]/`
- Hooks: Configuration in `hooks/hooks.json`
- MCP: Configuration in `.mcp.json`

Custom paths in `plugin.json` *supplement* (not replace) default directories.

## Component Creation Patterns

### Creating Agents

**Use the agent-creator agent** for AI-assisted generation:

```
"Create an agent that validates plugin structure"
```

Agent files require:
- **Identifier**: kebab-case, 3-50 chars (e.g., `code-reviewer`)
- **Description**: "Use this agent when..." with 2-4 `<example>` blocks showing triggers
- **System prompt**: Comprehensive instructions (500-3,000 words)
- **Frontmatter**: model, color, tools (optional)

**Location**: `agents/[identifier].md`

**Validation**: Run `scripts/validate-agent.sh agents/[identifier].md`

### Creating Skills

Skills follow progressive disclosure with strong trigger phrases:

**Frontmatter**:
```yaml
---
name: Skill Name
description: This skill should be used when the user asks to "trigger phrase", "another phrase", mentions "concept", or needs guidance on [topic]. [Additional context and trigger patterns.]
version: 0.1.0
---
```

**Writing style**:
- Description: Third person ("This skill should be used when...")
- Body: Imperative/infinitive form ("Create the file", "Verify the configuration")
- Length: 1,500-2,000 words for core SKILL.md
- References: Detailed content in `references/`, `examples/`, `scripts/` subdirectories

**Location**: `skills/[skill-name]/SKILL.md`

**Validation**: Use skill-reviewer agent to assess quality

### Creating Commands

Commands are slash commands with YAML frontmatter:

```markdown
---
description: Brief command purpose
argument-hint: What arguments it accepts
allowed-tools: ["Read", "Write", "Bash"]  # Minimal necessary
---

# Command instructions

Instructions written FOR Claude (not TO the user) about what to do when command is invoked.
```

**Key points**:
- Write instructions for Claude, not user documentation
- Use minimal `allowed-tools` (principle of least privilege)
- Provide clear `argument-hint` for user guidance

**Location**: `commands/[command-name].md`

### Creating Hooks

Hooks respond to Claude Code events. Two types:

**Prompt-based** (recommended for complex logic):
```json
{
  "PreToolUse": [{
    "matcher": "Write|Edit",
    "hooks": [{
      "type": "prompt",
      "prompt": "Verify that file edits don't introduce security vulnerabilities...",
      "temperature": 0.0
    }]
  }]
}
```

**Command-based** (for deterministic validation):
```json
{
  "PreToolUse": [{
    "matcher": "Bash",
    "hooks": [{
      "type": "command",
      "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/scripts/validate-bash.sh",
      "timeout": 30
    }]
  }]
}
```

**Events**: PreToolUse, PostToolUse, Stop, SubagentStop, SessionStart, SessionEnd, UserPromptSubmit, PreCompact, Notification

**Location**: `hooks/hooks.json`

**Validation**:
- Schema: `scripts/validate-hook-schema.sh hooks/hooks.json`
- Testing: `scripts/test-hook.sh hook-script.sh test-input.json`

### MCP Integration

MCP servers integrate external services:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "node",
      "args": ["${CLAUDE_PLUGIN_ROOT}/servers/server.js"],
      "env": {
        "API_KEY": "${API_KEY}"
      }
    }
  }
}
```

**Server types**:
- **stdio**: Local servers (Node.js, Python scripts)
- **SSE**: Hosted servers with OAuth
- **HTTP**: REST API servers
- **WebSocket**: Real-time servers

**Location**: `.mcp.json` at plugin root

## Naming Conventions

**Files and directories**: kebab-case
- `code-review.md`, `api-testing/`, `validate-input.sh`

**Identifiers** (agents, commands): kebab-case
- `test-generator`, `review-pr`, `deploy-staging`

**Skills**: descriptive directory names
- `hook-development/`, `api-design/`, `error-handling/`

**Avoid**: Spaces, underscores in names; generic terms like "helper", "utils" for components

## Common Workflows

### Creating a Complete Plugin

Use the guided workflow command:
```
/plugin-dev:create-plugin [optional description]
```

This runs an 8-phase process:
1. Discovery - Understand requirements
2. Component Planning - Determine needed components
3. Detailed Design - Resolve ambiguities
4. Structure Creation - Set up directories and manifest
5. Component Implementation - Create components using specialized agents
6. Validation - Run plugin-validator and component checks
7. Testing - Verify plugin works
8. Documentation - Finalize README and prepare for distribution

### Adding Components to Existing Work

**For agents**:
```
"Create an agent that [describes functionality]"
```
Uses agent-creator agent automatically.

**For skills**:
1. Load skill-development skill: mention "create a skill"
2. Create directory: `skills/[skill-name]/`
3. Write SKILL.md with frontmatter and body
4. Add references/, examples/, scripts/ as needed
5. Validate with skill-reviewer agent

**For hooks**:
1. Load hook-development skill: mention "create a hook"
2. Decide: prompt-based (flexible) or command-based (deterministic)
3. Add to `hooks/hooks.json`
4. Create scripts in `hooks/scripts/` if needed
5. Validate with `validate-hook-schema.sh`

## Available Specialized Agents

**agent-creator**: Generates agent configurations from descriptions
- Triggers: "create an agent", "generate an agent", "build a new agent"
- Creates: agents/[identifier].md with frontmatter and system prompt

**plugin-validator**: Validates plugin structure and quality
- Triggers: "validate plugin", "check plugin structure"
- Checks: manifest, naming, components, security, best practices

**skill-reviewer**: Reviews skill quality and adherence to patterns
- Triggers: "review skill", "validate skill quality"
- Checks: description, triggers, progressive disclosure, writing style

**conversation-analyzer** (hookify): Finds unwanted behaviors in conversation
- Triggers: When user runs `/hookify` without arguments
- Analyzes: Recent conversation for patterns to prevent

## Available Skills

Load these skills by mentioning their trigger phrases:

1. **hook-development**: "create a hook", "add a PreToolUse hook", "validate tool use"
2. **mcp-integration**: "add MCP server", "integrate MCP", "configure .mcp.json"
3. **plugin-structure**: "plugin structure", "plugin.json manifest", "auto-discovery"
4. **plugin-settings**: "plugin settings", "store plugin configuration", ".local.md files"
5. **command-development**: "create a slash command", "command frontmatter"
6. **agent-development**: "create an agent", "agent frontmatter", "when to use description"
7. **skill-development**: "create a skill", "add a skill to plugin", "improve skill description"

## Quality Standards

All components must meet these criteria:

**Security**:
- Input validation in hooks
- HTTPS/WSS for MCP servers
- Environment variables for credentials (never hardcode)
- Principle of least privilege for tool access

**Portability**:
- Use ${CLAUDE_PLUGIN_ROOT} everywhere
- Relative paths only in manifests
- Test on multiple platforms when possible

**Documentation**:
- Clear README files with setup instructions
- Document environment variables
- Provide usage examples
- Include troubleshooting sections

**Naming**:
- Consistent kebab-case throughout
- Descriptive, purpose-indicating names
- Avoid abbreviations and generic terms

**Structure**:
- Follow conventional directory layouts
- Use auto-discovery when possible
- Keep manifests minimal (rely on defaults)
- Separate concerns clearly

## Validation Tools

**For agents**:
```bash
./scripts/validate-agent.sh agents/[agent-name].md
```

**For hooks**:
```bash
./scripts/validate-hook-schema.sh hooks/hooks.json
./scripts/test-hook.sh hook-script.sh test-input.json
./scripts/hook-linter.sh hook-script.sh
```

**For entire plugins**:
```
"Use the plugin-validator agent to check the plugin"
```

## Testing Plugins

**Local testing**:
```bash
cc --plugin-dir /path/to/plugin-name
```

**Debug mode** (see hook execution, component loading):
```bash
claude --debug
```

**Component-specific testing**:
- Skills: Ask questions with trigger phrases
- Commands: Run `/plugin-name:command-name` with arguments
- Agents: Create scenarios matching agent examples
- Hooks: Trigger events, watch output in debug mode
- MCP: Use `/mcp` to verify servers and tools

## Development Guidelines

**When creating new components**:

1. **Understand before implementing**: Read relevant reference materials first
2. **Load appropriate skills**: Mention trigger phrases to load expertise
3. **Use specialized agents**: Leverage agent-creator, plugin-validator, skill-reviewer
4. **Follow patterns**: Study plugin-dev and hookfy as reference implementations
5. **Validate rigorously**: Run all applicable validation tools
6. **Test thoroughly**: Verify components work in actual Claude Code sessions

**When helping users**:

1. **Ask clarifying questions**: Don't assume - get specific requirements
2. **Present options**: Show trade-offs when multiple approaches exist
3. **Use progressive implementation**: Start simple, add complexity as needed
4. **Provide context**: Explain why patterns exist and when to use them
5. **Validate before delivery**: Run tools to catch issues early

## Key Reference Files

**For understanding plugin structure**:
- `reference/plugin-dev/skills/plugin-structure/SKILL.md`
- `reference/plugin-dev/skills/plugin-structure/references/component-patterns.md`

**For creating agents**:
- `reference/plugin-dev/agents/agent-creator.md`
- `reference/plugin-dev/skills/agent-development/SKILL.md`

**For creating skills**:
- `reference/plugin-dev/skills/skill-development/SKILL.md`

**For hooks**:
- `reference/plugin-dev/skills/hook-development/SKILL.md`
- `reference/plugin-dev/skills/hook-development/references/patterns.md`

**For MCP integration**:
- `reference/plugin-dev/skills/mcp-integration/SKILL.md`

**For complete workflow**:
- `reference/plugin-dev/commands/create-plugin.md`

## Notes on Repository Evolution

This repository is intended to be renamed to **prompt-dev** to better reflect its purpose as a collection of prompts and patterns for developing Claude Code components.

The materials here represent production-ready patterns extracted from successful Claude Code plugins. When creating new components, prefer these proven patterns over experimental approaches.
