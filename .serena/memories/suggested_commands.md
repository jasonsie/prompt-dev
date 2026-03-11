# Suggested Commands

## Testing the Plugin
```bash
cc --plugin-dir /Users/jason/Developer/y-pj/ai/plugin/prompt-dev
claude --debug
```

## Validation Scripts
```bash
./skills/agent-development/scripts/validate-agent.sh agents/<agent-name>.md
./skills/hook-development/scripts/validate-hook-schema.sh hooks/hooks.json
./skills/hook-development/scripts/test-hook.sh <hook-script> <test-input.json>
./skills/hook-development/scripts/hook-linter.sh <hook-script>
./skills/skill-development/scripts/validate-skill.sh
./skills/plugin-settings/scripts/validate-settings.sh
```

## Git
```bash
git status
git diff
git log --oneline -10
```
