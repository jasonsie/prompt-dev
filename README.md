# Prompt-Dev Plugin

Fast component scaffolding toolkit for Claude Code plugin development. Create agents, skills, commands, hooks, and complete plugins with specialized creator agents, automated validation, and quality review.

## Overview

**Prompt-Dev** accelerates Claude Code component development by providing:

- **Specialized Creator Agents**: AI-powered generators that craft high-quality components from descriptions
- **Built-in Quality Review**: Creator agents self-review using preloaded development skills
- **Comprehensive Skills**: Reference documentation for all aspects of plugin development
- **Validation Tools**: Ensure components meet Claude Code standards before deployment

## Features

### 🤖 Specialized Creator Agents

AI-powered generators that build components from natural language descriptions:

- **agent-creator** - Generates agent files with optimized configurations
- **skill-creator** - Creates skills with progressive disclosure patterns
- **command-creator** - Builds commands with proper frontmatter and structure
- **hook-creator** - Designs event hooks with appropriate matchers

### ✅ Built-in Quality Review

Creator agents preload development skills to self-review against quality standards:

- **agent-creator** - Self-reviews using agent-development skill
- **skill-creator** - Self-reviews using skill-development skill
- **command-creator** - Self-reviews using command-development skill
- **hook-creator** - Self-reviews using hook-development skill
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

```
"Create an agent that reviews code for security vulnerabilities"
```

The agent-creator will:
1. Understand your requirements
2. Design agent configuration (model, tools, color)
3. Generate the agent file
4. Validate structure
5. Self-review against agent-development standards
6. Offer to iterate on feedback

### Create a Skill

```
"Create a skill for API testing patterns and best practices"
```

The skill-creator will:
1. Clarify domain knowledge and usage scenarios
2. Plan resources (references/, examples/, scripts/)
3. Design trigger description
4. Generate the skill files
5. Self-review against skill-development standards
6. Iterate based on feedback

### Create a Complete Plugin

```
"Create a plugin for database migration management"
```

The plugin-validator helps verify:
1. Discovery - Understand requirements
2. Component Planning - Determine needed components
3. Detailed Design - Resolve ambiguities
4. Structure Creation - Set up directories and manifest
5. Component Implementation - Create all components
6. Validation - Run quality checks
7. Testing - Verify functionality
8. Documentation - Finalize and prepare for distribution

## Component Overview

### Agents (5)

Located in `agents/`:

**Creator Agents** (with skill-based self-review):
- `agent-creator.md` - AI-powered agent generation (preloads agent-development)
- `skill-creator.md` - Progressive disclosure skill building (preloads skill-development)
- `command-creator.md` - Command file generation (preloads command-development)
- `hook-creator.md` - Hook configuration design (preloads hook-development)

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
You: Create an agent that reviews pull requests for code quality, security issues, and best practices
Claude: Should it trigger proactively after PR creation, or on request?
You: On request, when I ask it to review code
Claude: [Creates agent using agent-creator, validates, reviews, presents feedback]
```

### Example 2: Create API Testing Skill

```
You: Create a skill for API testing patterns
Claude: What specific scenarios would use this skill?
You: When testing REST APIs, writing integration tests, mocking external services
Claude: [Plans resources, creates SKILL.md with references/, reviews quality]
```

### Example 3: Create Complete Database Plugin

```
You: Create a plugin for database migration management
Claude: [8-phase workflow]
  Phase 1: Understands migration use case
  Phase 2: Plans components (agents, skills, MCP)
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
- **Creator agent** for generation (preloads development skill for self-review)
- **Reference skill** for domain knowledge and quality standards

### Quality Assurance

Multi-layer validation ensures quality:
1. **Structural validation** - File structure, naming, frontmatter
2. **Content review** - Quality, completeness, best practices
3. **Pattern compliance** - Follows plugin-dev standards
4. **Testing guidance** - How to verify components work

## Best Practices

### When Creating Components

1. **Leverage creator agents** - Let AI generate boilerplate and structure
3. **Review thoroughly** - Creator agents self-review; use plugin-validator for final checks
4. **Test immediately** - Verify components work in Claude Code
5. **Iterate based on feedback** - Use review findings to improve quality

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

2. **Trigger a creator agent**
   - Describe what you need ("Create an agent that...")
   - Answer clarifying questions
   - Let creator agents generate files

3. **Review and validate**
   - Creator agents self-review using development skills
   - Address critical issues
   - Iterate on suggestions

4. **Test locally**
   - Load plugin in Claude Code
   - Verify triggering and functionality
   - Test edge cases

5. **Iterate and improve**
   - Use review findings
   - Add examples and documentation
   - Refine based on usage

## Validation Tools

### Built-in Validators

Creator agents perform self-review using preloaded development skills. For comprehensive validation:
- Complete plugins → `plugin-validator` agent
- Individual components → Creator agents self-review during creation

### Running Validation

Validation happens automatically in creation workflows, or run manually:

```bash
# Validate a complete plugin
"Use the plugin-validator agent to check my plugin"

# Create and auto-review a component
"Create an agent that reviews code quality"
# (agent-creator will self-review using agent-development skill)
```

## Troubleshooting

### Components Not Loading

**Issue**: Created components don't appear in Claude Code

**Solutions**:
1. Verify `.claude-plugin/plugin.json` exists
2. Check files are in correct directories (`agents/`, `skills/`)
3. Restart Claude Code session
4. Run plugin-validator to check structure

### Skills Not Triggering

**Issue**: Skills don't auto-load when expected

**Solutions**:
1. Check description has specific trigger phrases
2. Use exact phrases from description when asking questions
3. Verify SKILL.md exists in `skills/[name]/SKILL.md`
4. Re-create using skill-creator (which self-reviews trigger phrases)

### Agents Not Triggering

**Issue**: Agents don't activate on relevant requests

**Solutions**:
1. Check description has 2-4 `<example>` blocks
2. Verify examples show diverse triggering scenarios
3. Use phrases similar to examples in user messages
4. Re-create using agent-creator (which self-reviews description quality)

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
2. **Use creator agents** - Dog-food the plugin by using it to extend itself
3. **Validate rigorously** - Use plugin-validator before publishing
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
