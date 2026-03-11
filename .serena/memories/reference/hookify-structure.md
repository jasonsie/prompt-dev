# Hookify Plugin Reference (saved before reference/ removal)

## Structure
```
hookfy/
├── agents/conversation-analyzer.md   # Analyzes conversation for unwanted behaviors
├── commands/
│   ├── configure.md                  # Enable/disable rules interactively
│   ├── help.md                       # Plugin help
│   ├── hookify.md                    # Main command: create rules from instructions or conversation
│   └── list.md                       # List all configured rules
├── core/
│   ├── __init__.py
│   ├── config_loader.py              # Loads .local.md rule files from .claude/ dir
│   └── rule_engine.py                # Regex evaluation with LRU caching
├── hooks/
│   ├── __init__.py
│   ├── hooks.json                    # PreToolUse, PostToolUse, Stop, UserPromptSubmit
│   ├── pretooluse.py
│   ├── posttooluse.py
│   ├── stop.py
│   └── userpromptsubmit.py
├── matchers/__init__.py
├── utils/__init__.py
├── writing-rules/SKILL.md           # Skill for writing hookify rules
├── examples/                         # 4 example .local.md rule files
│   ├── console-log-warning.local.md
│   ├── dangerous-rm.local.md
│   ├── require-tests-stop.local.md
│   └── sensitive-files-warning.local.md
└── README.md
```

## Key Patterns
- Uses Python for hook scripts (not bash)
- Rules stored as `.claude/hookify.{name}.local.md` in project root
- Dynamic rule loading (no restart needed)
- YAML frontmatter in rules: name, enabled, event, pattern, action, conditions
- Action types: warn (default), block
- Event types: bash, file, stop, prompt, all
- hooks.json runs Python scripts via `python3 ${CLAUDE_PLUGIN_ROOT}/hooks/pretooluse.py`
- Skill directory is `writing-rules/` (non-standard, not under `skills/`)
