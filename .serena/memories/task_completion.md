# Task Completion Checklist

1. **Validate components**: Run relevant validation scripts for modified components
2. **Check naming**: Ensure kebab-case for all files and identifiers
3. **Verify paths**: All intra-plugin paths use `${CLAUDE_PLUGIN_ROOT}`
4. **Check progressive disclosure**: Skills keep SKILL.md lean (1,500-2,000 words)
5. **Update CLAUDE.md**: If structural changes were made, update project instructions
6. **Test locally**: Load plugin with `cc --plugin-dir` and verify

No build, lint, or test commands to run (pure markdown/shell project).
