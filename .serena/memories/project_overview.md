# Project Overview: prompt-dev

## Purpose
A Claude Code plugin (meta-toolkit) for scaffolding plugin components: agents, skills, commands, hooks, and complete plugins. Provides specialized creator agents (with skill-based self-review), reference skills, and validation tools.

## Tech Stack
- **Language**: Bash (shell scripts), Markdown (component definitions)
- **Platform**: Claude Code plugin system
- **No build system**: Pure markdown + shell scripts

## Repository Structure
```
prompt-dev/
├── .claude-plugin/
│   ├── plugin.json         # Plugin manifest
│   └── marketplace.json    # Marketplace config
├── agents/                 # 5 agents (4 creators, 1 validator)
├── skills/                 # 7 skills with progressive disclosure
│   ├── agent-development/
│   ├── command-development/
│   ├── hook-development/
│   ├── mcp-integration/
│   ├── plugin-settings/
│   ├── plugin-structure/
│   └── skill-development/
├── CLAUDE.md              # Project instructions
└── README.md              # Documentation
```

## Key Patterns
- **Progressive Disclosure**: Skills use 3 tiers (metadata -> SKILL.md -> references/examples/scripts)
- **Component Architecture**: Each type has creator agent + reference skill
- **Portability**: `${CLAUDE_PLUGIN_ROOT}` for all paths
- **Auto-Discovery**: Components in standard directories
- **Naming**: kebab-case everywhere

## Hookify reference
The hookify plugin reference was previously in reference/hookfy/ (now removed).
Key patterns saved in Serena memory: reference/hookify-structure
Templates saved in: reference/plugin-dev-templates
