# Common Mistakes to Avoid

This guide catalogs common mistakes when creating Claude Code plugin skills and how to fix them.

## Mistake 1: Weak Trigger Description

### ❌ Bad Example

```yaml
description: Provides guidance for working with hooks.
```

**Why bad:**
- Vague and generic
- No specific trigger phrases
- Not in third person
- Doesn't tell Claude when to load

### ✅ Good Example

```yaml
description: This skill should be used when the user asks to "create a hook", "add a PreToolUse hook", "validate tool use", or mentions hook events. Provides comprehensive hooks API guidance.
```

**Why good:**
- Third person format
- Specific user phrases in quotes
- Concrete scenarios
- Clear triggering conditions

### How to Fix

1. Start with "This skill should be used when..."
2. Include 3-5 specific trigger phrases users would say
3. Use quotes around exact phrases
4. Add conceptual triggers ("mentions X", "needs guidance on Y")
5. Be concrete and specific

---

## Mistake 2: Too Much in SKILL.md

### ❌ Bad Example

```
skill-name/
└── SKILL.md  (8,000 words - everything in one file)
```

**Why bad:**
- Bloats context window when skill loads
- Detailed content always loaded even when not needed
- Harder to maintain
- No progressive disclosure
- Slower loading

### ✅ Good Example

```
skill-name/
├── SKILL.md  (1,800 words - core essentials)
└── references/
    ├── patterns.md (2,500 words)
    └── advanced.md (3,700 words)
```

**Why good:**
- Progressive disclosure implemented
- Core content in SKILL.md
- Detailed content loaded only when needed
- Better context management
- Easier to maintain

### How to Fix

1. Identify sections over 500 words
2. Evaluate if they're "core" or "detailed"
3. Move detailed content to references/
4. Add references section in SKILL.md
5. Keep SKILL.md under 3,000 words (ideally 1,500-2,000)

---

## Mistake 3: Second Person Writing

### ❌ Bad Example

```markdown
You should start by reading the configuration file.
You need to validate the input.
You can use the grep tool to search.
```

**Why bad:**
- Uses second person ("you")
- Not imperative form
- Feels conversational, not instructional
- Inconsistent with Claude Code style

### ✅ Good Example

```markdown
Start by reading the configuration file.
Validate the input before processing.
Use the grep tool to search for patterns.
```

**Why good:**
- Imperative form (verb-first)
- Direct instructions
- Objective, instructional tone
- Consistent style

### How to Fix

1. Remove all instances of "you"
2. Start sentences with verbs (imperative form)
3. Use infinitive form: "To accomplish X, do Y"
4. Avoid personal pronouns
5. Focus on actions, not actors

---

## Mistake 4: Missing Resource References

### ❌ Bad Example

```markdown
# SKILL.md

[Core content about the skill]

[No mention of references/ or examples/]
```

**Why bad:**
- Claude doesn't know additional resources exist
- Supporting files go unused
- User misses helpful examples
- Defeats progressive disclosure

### ✅ Good Example

```markdown
# SKILL.md

[Core content about the skill]

## Additional Resources

### Reference Files

For detailed patterns and techniques, consult:
- **`references/patterns.md`** - Common hook patterns (8+ proven patterns)
- **`references/advanced.md`** - Advanced techniques and edge cases

### Example Files

Working examples in `examples/`:
- **`validate-write.sh`** - File write validation hook
- **`example-config.json`** - Example configuration
```

**Why good:**
- Claude knows where to find more information
- Clear descriptions of each resource
- Organized by type (references vs examples)
- Enables progressive loading

### How to Fix

1. Create "Additional Resources" section at end of SKILL.md
2. List all references/ files with descriptions
3. List all examples/ files with descriptions
4. List all scripts/ with descriptions
5. Make it easy for Claude to find relevant resources

---

## Mistake 5: Vague or Generic Names

### ❌ Bad Examples

```
skills/utils/SKILL.md
skills/helper/SKILL.md
skills/misc/SKILL.md
```

**Why bad:**
- Names don't indicate purpose
- Hard to understand what skill does
- Poor triggering
- Confusing for users

### ✅ Good Examples

```
skills/hook-development/SKILL.md
skills/mcp-integration/SKILL.md
skills/plugin-settings/SKILL.md
```

**Why good:**
- Clear, specific names
- Indicates exactly what skill covers
- Better for triggering
- Easy for users to understand

### How to Fix

1. Use descriptive, specific names
2. Name after the domain or feature
3. Use kebab-case
4. Avoid generic terms (helper, utils, misc)
5. Make purpose clear from name

---

## Mistake 6: No Examples or Scripts

### ❌ Bad Example

```
skill-name/
└── SKILL.md  (just documentation, no working code)
```

**Why bad:**
- Users can't see working implementations
- Claude might rewrite same code repeatedly
- No utilities to help with common tasks
- Misses opportunity for deterministic tools

### ✅ Good Example

```
skill-name/
├── SKILL.md
├── examples/
│   ├── basic-example.sh
│   └── advanced-config.json
└── scripts/
    ├── validate.sh
    └── test.sh
```

**Why good:**
- Working examples users can copy
- Utilities for common operations
- Deterministic validation
- Complete implementation reference

### How to Fix

1. Identify code that gets rewritten repeatedly
2. Create working examples in examples/
3. Build validation utilities in scripts/
4. Make scripts executable
5. Document what each file does

---

## Mistake 7: Ignoring Validation

### ❌ Bad Practice

```
1. Write skill
2. Commit immediately
3. Hope it works
```

**Why bad:**
- Bugs only found in production
- Poor trigger descriptions go unnoticed
- Structure issues not caught
- Users encounter broken skills

### ✅ Good Practice

```
1. Write skill
2. Check structure (frontmatter, files exist)
3. Validate trigger phrases
4. Test with real queries
5. Use skill-reviewer agent
6. Fix issues before committing
```

**Why good:**
- Catches issues early
- Ensures quality
- Verifies triggering works
- Better user experience

### How to Fix

1. Create validation checklist
2. Test trigger phrases manually
3. Use skill-reviewer agent
4. Verify all referenced files exist
5. Test in real Claude Code session

---

## Mistake 8: Duplication Between Files

### ❌ Bad Example

```
SKILL.md: "To validate hooks, check the JSON schema..."
references/validation.md: "To validate hooks, check the JSON schema..."
```

**Why bad:**
- Same information loaded twice
- Wastes context window
- Maintenance burden (update two places)
- Confusing which is authoritative

### ✅ Good Example

```
SKILL.md: "For detailed validation procedures, see `references/validation.md`"
references/validation.md: "To validate hooks, check the JSON schema..."
```

**Why good:**
- Information lives in one place
- SKILL.md points to details
- Efficient context usage
- Single source of truth

### How to Fix

1. Audit for duplicated content
2. Choose one location for each piece of information
3. Remove duplicates
4. Add references from SKILL.md to details
5. Maintain single source of truth

---

## Mistake 9: Unclear Directory Structure

### ❌ Bad Example

```
skill-name/
├── SKILL.md
├── file1.md
├── file2.sh
├── example.json
└── some-script.py
```

**Why bad:**
- Unclear organization
- Hard to find specific resources
- No clear categorization
- Confusing for both Claude and users

### ✅ Good Example

```
skill-name/
├── SKILL.md
├── references/
│   ├── patterns.md
│   └── advanced.md
├── examples/
│   └── example-config.json
└── scripts/
    └── validation.sh
```

**Why good:**
- Clear organization
- Easy to find resources
- Obvious categorization
- Standard structure

### How to Fix

1. Create standard directories (references/, examples/, scripts/)
2. Move files to appropriate directories
3. Use descriptive filenames
4. Delete unused directories
5. Follow plugin-dev patterns

---

## Mistake 10: No Iteration

### ❌ Bad Practice

```
1. Create skill once
2. Never update it
3. Ignore usage feedback
```

**Why bad:**
- Skill doesn't improve
- Misses opportunities for optimization
- Trigger phrases don't evolve
- User pain points persist

### ✅ Good Practice

```
1. Create initial skill
2. Use it on real tasks
3. Notice what works and what doesn't
4. Update trigger phrases
5. Add missing examples
6. Improve based on actual usage
```

**Why good:**
- Skill gets better over time
- Responds to real needs
- Trigger phrases improve
- Better user experience

### How to Fix

1. Track skill usage and issues
2. Collect feedback after using skill
3. Identify pain points
4. Update trigger phrases
5. Add missing resources
6. Test improvements

---

## Quick Validation Checklist

Before finalizing any skill, check:

- [ ] Description uses third person
- [ ] 3-5 specific trigger phrases included
- [ ] SKILL.md is 1,500-2,000 words (max 3,000)
- [ ] Detailed content in references/
- [ ] Working examples in examples/
- [ ] Utilities in scripts/ (if needed)
- [ ] All referenced files exist
- [ ] No second person writing
- [ ] No duplication between files
- [ ] Proper directory structure
- [ ] Tested with real queries

## Resources

For more on skill development best practices:
- Study the skills in `../../` (hook-development, agent-development, etc.)
- Use the skill-reviewer agent for automated validation
- Refer to `progressive-disclosure-guide.md` for organization guidance
