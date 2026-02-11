# Progressive Disclosure in Practice

This guide provides detailed guidance on implementing progressive disclosure in Claude Code plugin skills.

## What Goes in SKILL.md

**Include (always loaded when skill triggers):**
- Core concepts and overview
- Essential procedures and workflows
- Quick reference tables
- Pointers to references/examples/scripts
- Most common use cases

**Keep under 3,000 words, ideally 1,500-2,000 words**

## What Goes in references/

**Move to references/ (loaded as needed):**
- Detailed patterns and advanced techniques
- Comprehensive API documentation
- Migration guides
- Edge cases and troubleshooting
- Extensive examples and walkthroughs

**Each reference file can be large (2,000-5,000+ words)**

## What Goes in examples/

**Working code examples:**
- Complete, runnable scripts
- Configuration files
- Template files
- Real-world usage examples

**Users can copy and adapt these directly**

## What Goes in scripts/

**Utility scripts:**
- Validation tools
- Testing helpers
- Parsing utilities
- Automation scripts

**Should be executable and documented**

## Decision Framework

When deciding where content should live:

### SKILL.md → Core essentials
- Is this needed to understand what the skill does?
- Is this essential for the most common use case?
- Is this a key concept that should always be in context?
→ Put it in SKILL.md

### references/ → Detailed content
- Is this advanced or specialized knowledge?
- Is this only needed occasionally?
- Is this detailed documentation or comprehensive guides?
→ Put it in references/

### examples/ → Working code
- Is this a complete, runnable example?
- Can users copy this directly?
- Is this a template or configuration file?
→ Put it in examples/

### scripts/ → Utilities
- Is this a tool that should be executed?
- Does this provide validation or automation?
- Is this something that would be rewritten repeatedly?
→ Put it in scripts/

## Example: Hook Development Skill

**SKILL.md (1,651 words):**
- Overview of hooks
- Core hook types (prompt, command, agent)
- Essential event types
- Basic security principles
- References to supporting files

**references/ (3 files):**
- `patterns.md` (2,500 words) - 8 proven hook patterns
- `migration.md` (1,800 words) - Migrating from basic to advanced
- `advanced.md` (3,200 words) - Advanced techniques and edge cases

**examples/ (3 files):**
- `validate-write.sh` - File write validation hook
- `validate-bash.sh` - Bash command validation hook
- `load-context.sh` - SessionStart context loading

**scripts/ (3 files + README):**
- `validate-hook-schema.sh` - JSON schema validation
- `test-hook.sh` - Hook testing utility
- `hook-linter.sh` - Hook script linting

## Benefits of Progressive Disclosure

1. **Faster skill loading:** Only core content loads when skill triggers
2. **Better context management:** Detailed docs load only when Claude needs them
3. **Easier maintenance:** Update references without changing core skill
4. **Clearer organization:** Each file has a focused purpose
5. **Scalable growth:** Add references without bloating SKILL.md

## Anti-Patterns to Avoid

❌ **Everything in SKILL.md:**
```
skill-name/
└── SKILL.md (8,000 words)
```
Problem: Entire skill loads every time, wastes context

❌ **No organization:**
```
skill-name/
├── SKILL.md (500 words)
└── references/
    └── everything.md (15,000 words)
```
Problem: One giant reference file is hard to navigate

❌ **Unreferenced resources:**
```
skill-name/
├── SKILL.md (doesn't mention references/)
└── references/
    └── detailed-guide.md
```
Problem: Claude doesn't know the guide exists

✅ **Proper progressive disclosure:**
```
skill-name/
├── SKILL.md (1,800 words, references other files)
├── references/
│   ├── patterns.md (2,500 words)
│   └── advanced.md (3,200 words)
├── examples/
│   ├── basic.sh
│   └── advanced.json
└── scripts/
    └── validate.sh
```
Benefits: Lean core, organized resources, clear references

## Implementation Checklist

When implementing progressive disclosure:

- [ ] SKILL.md is 1,500-2,000 words (max 3,000)
- [ ] Core concepts in SKILL.md
- [ ] Detailed content moved to references/
- [ ] Working examples in examples/
- [ ] Utilities in scripts/
- [ ] SKILL.md references all supporting files
- [ ] Each reference file has a focused purpose
- [ ] No duplication between SKILL.md and references/
- [ ] File names are descriptive and clear

## Testing Progressive Disclosure

Verify your progressive disclosure implementation:

1. **Check SKILL.md length:** Should be under 3,000 words
2. **Verify references exist:** All mentioned files are present
3. **Test loading:** Skill should load quickly
4. **Confirm organization:** Each file has clear purpose
5. **Validate no duplication:** Info lives in one place only
