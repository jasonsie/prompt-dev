# Style and Conventions

## File Naming
- All files and directories: kebab-case
- Agent files: `agents/<identifier>.md`
- Skill directories: `skills/<skill-name>/SKILL.md`
- Commands: `commands/<command-name>.md`

## Agent Files
- YAML frontmatter: name, description, model, color, tools
- Description starts with "Use this agent when..."
- 2-4 `<example>` blocks showing trigger scenarios
- System prompt: 500-3,000 words

## Skill Files
- YAML frontmatter: name, description, version
- Description: third person ("This skill should be used when...")
- Body: imperative/infinitive form ("Create the file", "Validate the input")
- Never second person ("You should...")
- Core SKILL.md: 1,500-2,000 words
- Detailed content in references/, examples/, scripts/

## Command Files
- YAML frontmatter: description, argument-hint, allowed-tools
- Instructions written FOR Claude (not user documentation)
- Minimal allowed-tools (principle of least privilege)

## Path References
- Always use `${CLAUDE_PLUGIN_ROOT}` for intra-plugin paths
- Never hardcoded absolute paths
