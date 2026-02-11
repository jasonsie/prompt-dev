# Prompt-Dev Plugin

Fast component scaffolding toolkit for Claude Code plugin development. Create agents, skills, commands, hooks, and complete plugins with guided workflows, automated validation, and quality review.

## Overview

**Prompt-Dev** accelerates Claude Code component development by providing:

- **Guided Creation Workflows**: Step-by-step commands that walk you through creating each component type
- **Specialized Creator Agents**: AI-powered generators that craft high-quality components from descriptions
- **Quality Review System**: Automated reviewers that validate structure, quality, and best practices
- **Comprehensive Skills**: Reference documentation for all aspects of plugin development
- **Validation Tools**: Ensure components meet Claude Code standards before deployment

## Features

### 🚀 Fast Scaffolding Commands

Create components with or without arguments:

- `/create-agent [description]` - Generate agent configurations with AI assistance
- `/create-skill [description]` - Build skills with progressive disclosure design
- `/create-command [description]` - Scaffold slash commands with proper structure
- `/create-hook [description]` - Create event hooks with validation
- `/create-plugin [description]` - Scaffold complete plugin structures (full 8-phase workflow)

### 🤖 Specialized Creator Agents

AI-powered generators that build components from natural language descriptions:

- **agent-creator** - Generates agent files with optimized configurations
- **skill-creator** - Creates skills with progressive disclosure patterns
- **command-creator** - Builds commands with proper frontmatter and structure
- **hook-creator** - Designs event hooks with appropriate matchers

### ✅ Quality Review System

Automated reviewers that validate and improve your components:

- **agent-reviewer** - Validates agent descriptions, examples, and system prompts
- **skill-reviewer** - Checks progressive disclosure, trigger phrases, writing style
- **command-reviewer** - Reviews command structure, tools, and documentation
- **hook-reviewer** - Validates hook configuration and implementation
- **plugin-validator** - Comprehensive plugin structure and quality validation

### 📚 Reference Skills

Auto-loading knowledge modules for plugin development:

- **agent-development** - Agent creation patterns, frontmatter, triggering
- **skill-development** - Progressive disclosure, trigger phrases, organization
- **command-development** - Command structure, arguments, tool permissions
- **hook-development** - Event hooks, matchers, prompt vs command-based hooks
- **plugin-structure** - Directory layout, manifests, auto-discovery
- **plugin-settings** - Configuration files, .local.md patterns, YAML frontmatter
- **mcp-integration** - MCP server configuration, external service integration

## Installation

### Local Development

```bash
cc --plugin-dir /Users/jason/Developer/y-pj/ai/plugin/prompt-dev
```

### Project-Specific

Copy to your project's plugin directory:

```bash
cp -r prompt-dev ~/.claude/plugins/
```

## Quick Start

### Create an Agent

```bash
# Interactive workflow
/create-agent

# With description
/create-agent "reviews code for security vulnerabilities"
```

The command will:
1. Understand your requirements
2. Design agent configuration (model, tools, color)
3. Use agent-creator to generate the file
4. Validate structure
5. Review quality with agent-reviewer
6. Offer to iterate on feedback

### Create a Skill

```bash
# Interactive workflow
/create-skill

# With description
/create-skill "API testing patterns and best practices"
```

The command will:
1. Clarify domain knowledge and usage scenarios
2. Plan resources (references/, examples/, scripts/)
3. Design trigger description
4. Use skill-creator to generate files
5. Validate and review with skill-reviewer
6. Iterate based on feedback

### Create a Complete Plugin

```bash
# Full guided workflow
/create-plugin

# With description
/create-plugin "database migration management"
```

Runs comprehensive 8-phase process:
1. Discovery - Understand requirements
2. Component Planning - Determine needed components
3. Detailed Design - Resolve ambiguities
4. Structure Creation - Set up directories and manifest
5. Component Implementation - Create all components
6. Validation - Run quality checks
7. Testing - Verify functionality
8. Documentation - Finalize and prepare for distribution

## Component Overview

### Commands (5)

Located in `commands/`:

| Command | Purpose |
|---------|---------|
| `create-agent.md` | 6-phase guided agent creation workflow |
| `create-skill.md` | 7-phase guided skill creation workflow |
| `create-command.md` | Command scaffolding with frontmatter |
| `create-hook.md` | Event hook creation and configuration |
| `create-plugin.md` | Complete plugin scaffolding (8 phases) |

### Agents (9)

Located in `agents/`:

**Creator Agents:**
- `agent-creator.md` - AI-powered agent generation
- `skill-creator.md` - Progressive disclosure skill building
- `command-creator.md` - Command file generation
- `hook-creator.md` - Hook configuration design

**Reviewer Agents:**
- `agent-reviewer.md` - Agent quality validation
- `skill-reviewer.md` - Skill structure and style review
- `command-reviewer.md` - Command validation
- `hook-reviewer.md` - Hook configuration review

**Validator:**
- `plugin-validator.md` - Comprehensive plugin validation

### Skills (7)

Located in `skills/`:

| Skill | Trigger When... |
|-------|-----------------|
| `agent-development/` | Creating agents, agent frontmatter, triggering patterns |
| `skill-development/` | Creating skills, progressive disclosure, trigger phrases |
| `command-development/` | Creating commands, frontmatter, arguments, tool permissions |
| `hook-development/` | Creating hooks, event types, matchers, prompt-based hooks |
| `plugin-structure/` | Plugin organization, manifests, auto-discovery, paths |
| `plugin-settings/` | Plugin configuration, .local.md files, user settings |
| `mcp-integration/` | MCP servers, external services, server types |

## Usage Examples

### Example 1: Create a Code Review Agent

```
You: /create-agent
Claude: What should this agent do?
You: Review pull requests for code quality, security issues, and best practices
Claude: Should it trigger proactively after PR creation, or on request?
You: On request, when I ask it to review code
Claude: [Creates agent using agent-creator, validates, reviews, presents feedback]
```

### Example 2: Create API Testing Skill

```
You: /create-skill API testing patterns
Claude: What specific scenarios would use this skill?
You: When testing REST APIs, writing integration tests, mocking external services
Claude: [Plans resources, creates SKILL.md with references/, reviews quality]
```

### Example 3: Create Complete Database Plugin

```
You: /create-plugin database migration management
Claude: [8-phase workflow]
  Phase 1: Understands migration use case
  Phase 2: Plans components (commands, skills, MCP)
  Phase 3: Asks clarifying questions about DB types, formats
  Phase 4: Creates plugin structure
  Phase 5: Implements all components using creator agents
  Phase 6: Validates with plugin-validator
  Phase 7: Guides you through testing
  Phase 8: Finalizes documentation
```

## Architecture

### Progressive Disclosure Pattern

Skills follow three-tier information architecture:

1. **Metadata** (always loaded): Concise descriptions with trigger phrases
2. **Core content** (when triggered): Essential reference in SKILL.md (~1,500-2,000 words)
3. **Resources** (as needed): Detailed guides in references/, examples/, scripts/

### Component-Based Design

Each component type has:
- **Creator** agent for generation
- **Reviewer** agent for validation
- **Reference skill** for guidance
- **Guided command** for interactive workflows

### Quality Assurance

Multi-layer validation ensures quality:
1. **Structural validation** - File structure, naming, frontmatter
2. **Content review** - Quality, completeness, best practices
3. **Pattern compliance** - Follows plugin-dev standards
4. **Testing guidance** - How to verify components work

## Best Practices

### When Creating Components

1. **Start with commands** - Use guided workflows for interactive creation
2. **Leverage creator agents** - Let AI generate boilerplate and structure
3. **Review thoroughly** - Always run reviewers before finalizing
4. **Test immediately** - Verify components work in Claude Code
5. **Iterate based on feedback** - Use reviewer suggestions to improve quality

### Naming Conventions

- **Agents**: `action-target` (e.g., `code-reviewer`, `test-generator`)
- **Skills**: Descriptive directory names (e.g., `api-testing/`, `error-handling/`)
- **Commands**: `action-object` (e.g., `create-agent`, `deploy-app`)
- **All files**: kebab-case consistently

### File Organization

```
your-plugin/
├── .claude-plugin/
│   └── plugin.json          # Required manifest
├── agents/                  # Specialized agents
├── commands/                # Slash commands
├── skills/                  # Knowledge modules
│   └── skill-name/
│       ├── SKILL.md        # Core content
│       ├── references/     # Detailed docs
│       ├── examples/       # Working code
│       └── scripts/        # Utilities
├── hooks/                   # Event handlers (optional)
├── .mcp.json               # MCP servers (optional)
└── README.md               # Documentation
```

## Development Workflow

### Typical Development Session

1. **Plan your component**
   - Decide what you're building (agent, skill, command, etc.)
   - Gather requirements and examples

2. **Run the creation command**
   - Use `/create-agent`, `/create-skill`, etc.
   - Answer guided questions
   - Let creator agents generate files

3. **Review and validate**
   - Automatic review by specialized reviewers
   - Address critical issues
   - Iterate on suggestions

4. **Test locally**
   - Load plugin in Claude Code
   - Verify triggering and functionality
   - Test edge cases

5. **Iterate and improve**
   - Use reviewer feedback
   - Add examples and documentation
   - Refine based on usage

## Validation Tools

### Built-in Validators

Each component type has a specialized reviewer:
- Agent files → `agent-reviewer` agent
- Skills → `skill-reviewer` agent
- Commands → `command-reviewer` agent
- Hooks → `hook-reviewer` agent
- Complete plugins → `plugin-validator` agent

### Running Validation

Validation happens automatically in creation workflows, or run manually:

```bash
# Validate a complete plugin
"Use the plugin-validator agent to check my plugin"

# Review a specific skill
"Use the skill-reviewer agent to review the api-testing skill"

# Validate an agent
"Use the agent-reviewer agent to check the code-reviewer agent"
```

## Troubleshooting

### Components Not Loading

**Issue**: Created components don't appear in Claude Code

**Solutions**:
1. Verify `.claude-plugin/plugin.json` exists
2. Check files are in correct directories (commands/, agents/, skills/)
3. Restart Claude Code session
4. Run plugin-validator to check structure

### Skills Not Triggering

**Issue**: Skills don't auto-load when expected

**Solutions**:
1. Check description has specific trigger phrases
2. Use exact phrases from description when asking questions
3. Verify SKILL.md exists in `skills/[name]/SKILL.md`
4. Review with skill-reviewer for trigger phrase quality

### Agents Not Triggering

**Issue**: Agents don't activate on relevant requests

**Solutions**:
1. Check description has 2-4 `<example>` blocks
2. Verify examples show diverse triggering scenarios
3. Use phrases similar to examples in user messages
4. Review with agent-reviewer for description quality

### Path Resolution Errors

**Issue**: Scripts or resources not found

**Solutions**:
1. Use `${CLAUDE_PLUGIN_ROOT}` for all intra-plugin paths
2. Verify relative paths in plugin.json start with `./`
3. Check referenced files actually exist
4. Test paths with `echo $CLAUDE_PLUGIN_ROOT` in hooks

## Contributing

When extending this plugin:

1. **Follow existing patterns** - Study current components as reference
2. **Use the creation commands** - Dog-food the plugin by using it to extend itself
3. **Validate rigorously** - Run all reviewers before adding components
4. **Document thoroughly** - Update README and component docs
5. **Test comprehensively** - Verify new components work in Claude Code

## License

MIT

## Support

For issues, questions, or feature requests:
1. Check troubleshooting section above
2. Review reference skills for guidance
3. Use plugin-validator to diagnose issues
4. Consult CLAUDE.md for architectural principles

---

**Built with prompt-dev** - This plugin uses its own tools for development and maintenance.
