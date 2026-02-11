---
description: Guided skill creation workflow with progressive disclosure design
argument-hint: Optional skill description
allowed-tools: ["Read", "Write", "Grep", "Glob", "Bash", "Task", "TaskCreate", "TaskUpdate", "AskUserQuestion"]
---

# Skill Creation Workflow

Guide the user through creating a high-quality Claude Code skill with progressive disclosure design, from initial concept to validated implementation. Follow a systematic approach: understand domain knowledge, plan resources, design structure, create files, validate, review, and iterate.

## Core Principles

- **Ask clarifying questions**: Understand the domain knowledge or workflows the skill encodes
- **Use skill-creator agent**: Leverage the specialized agent for AI-assisted generation
- **Use skill-reviewer agent**: Get quality feedback on generated skills
- **Follow progressive disclosure**: Keep SKILL.md lean (1,500-2,000 words), detailed content in references/
- **Use TaskCreate/TaskUpdate**: Track progress throughout all phases

**Initial request:** $ARGUMENTS

---

## Phase 1: Discovery

**Goal**: Understand what domain knowledge or workflows the skill should provide

**Actions**:
1. Create todo list with all 7 phases using TaskCreate
2. If skill purpose is clear from arguments:
   - Summarize understanding
   - Identify skill type (knowledge, workflow, integration, toolkit)
3. If skill purpose is unclear, ask user:
   - What domain knowledge should this skill provide?
   - What should Claude be able to do with this skill loaded?
   - What specific user questions should trigger it?
   - Any concrete usage examples?
4. Summarize understanding and confirm before proceeding

**Output**: Clear statement of skill purpose and domain

---

## Phase 2: Understand with Concrete Examples

**Goal**: Clarify how the skill will be used in practice

**Actions**:
1. Ask user for concrete usage scenarios (use AskUserQuestion):
   - "What are 2-3 specific scenarios where you'd use this skill?"
   - "Can you give example questions or requests that should trigger it?"
   - "What should Claude know or be able to do that it currently can't?"

2. For each example, analyze:
   - What information or workflow is needed
   - What resources would help (scripts, references, templates)
   - What level of detail is appropriate

**Output**: 2-3 concrete usage examples with context

---

## Phase 3: Plan Resources

**Goal**: Determine what files the skill needs

**Actions**:
1. Analyze usage examples and plan structure:
   - **SKILL.md** (required): Core instructions, 1,500-2,000 words
   - **references/**: Detailed documentation, patterns, advanced topics (2,000-5,000+ words each)
   - **examples/**: Working code examples, configuration files, templates
   - **scripts/**: Utility scripts for common operations
   - **assets/**: Templates, images used in output (not loaded into context)

2. Present planned structure to user:
   ```
   skills/[skill-name]/
   ├── SKILL.md (core essentials)
   ├── references/
   │   ├── patterns.md (if needed)
   │   └── advanced.md (if needed)
   ├── examples/
   │   └── example-file (if needed)
   └── scripts/
       └── utility.sh (if needed)
   ```

3. Get user confirmation or adjustments

**Output**: Confirmed skill directory structure plan

---

## Phase 4: Design Trigger Description

**Goal**: Create effective trigger phrases for auto-activation

**Actions**:
1. Based on usage examples, draft trigger description:
   - Use third person: "This skill should be used when..."
   - Include specific trigger phrases from user's examples
   - List concrete scenarios that should activate it

2. Present draft to user:
   ```yaml
   description: This skill should be used when the user asks to "phrase 1", "phrase 2", mentions "concept", or needs guidance on [topic].
   ```

3. Ask user: "Does this description capture all the scenarios where you'd want this skill to activate?"

4. Refine based on feedback

**Output**: Finalized trigger description with specific phrases

---

## Phase 5: Create Skill Files

**Goal**: Generate SKILL.md and supporting files

**Actions**:
1. Determine skill location:
   - Plugin: `skills/[skill-name]/`
   - Project: `.claude/skills/[skill-name]/` (if supported)

2. Use Task tool to spawn skill-creator agent:
   - Provide domain purpose from Phase 1
   - Include usage examples from Phase 2
   - Include resource plan from Phase 3
   - Include trigger description from Phase 4
   - Skill-creator will generate all files

3. Wait for skill-creator to complete

**Output**: Skill directory with SKILL.md and supporting files created

---

## Phase 6: Validate & Review

**Goal**: Ensure skill meets quality standards

**Actions**:
1. **Validate Structure** using plugin-validator:
   - Use Task tool to spawn plugin-validator agent
   - Ask it to validate the skill
   - Check frontmatter, file structure, references

2. **Review Quality** using skill-reviewer:
   - Use Task tool to spawn skill-reviewer agent
   - Agent will assess:
     - Description quality (trigger phrases)
     - Progressive disclosure (SKILL.md length, references organization)
     - Writing style (imperative form, not second person)
     - Content quality and completeness

3. Present findings to user:
   - Critical issues (must fix)
   - Major issues (should fix)
   - Minor suggestions (optional)
   - Positive aspects

4. Ask user: "Skill created and reviewed. Issues found: [count]. Would you like me to fix the issues now?"

**Output**: Validation and review reports with recommendations

---

## Phase 7: Iterate (Optional)

**Goal**: Fix issues and improve skill based on feedback

**Actions**:
1. If user wants fixes, address by priority:
   - Critical: Description improvements, file structure fixes
   - Major: Progressive disclosure adjustments, writing style corrections
   - Minor: Content enhancements, additional examples

2. Common improvements:
   - Strengthen trigger phrases in description
   - Move long sections from SKILL.md to references/
   - Add missing examples or scripts
   - Clarify ambiguous instructions
   - Improve organization and flow

3. After fixes, offer to re-review:
   - Run skill-reviewer again
   - Verify improvements
   - Confirm issues resolved

4. Provide final summary:
   - Skill name and location
   - File structure created
   - How to test it
   - Next steps

**Output**: Improved skill ready for use

---

## Testing Recommendations

After creation, suggest the user test the skill by:

1. **Install plugin/project**:
   ```bash
   cc --plugin-dir /path/to/plugin
   ```

2. **Test triggering** using phrases from the description:
   - Ask questions with exact trigger phrases
   - Verify skill loads (look for skill name in Claude's response)
   - Check that skill provides relevant guidance

3. **Test progressive disclosure**:
   - Verify SKILL.md loads when skill triggers
   - Check that references/ files load when Claude needs them
   - Confirm examples/ are accessible

4. **Verify content quality**:
   - Is the guidance helpful and accurate?
   - Are examples complete and correct?
   - Do scripts work as expected?

---

## Important Notes

### Throughout All Phases

- **Use TaskCreate/TaskUpdate** to track progress
- **Load skill-development skill** if needing reference material
- **Use specialized agents** (skill-creator, skill-reviewer, plugin-validator)
- **Ask for confirmation** at key decision points
- **Apply best practices**:
  - Third-person descriptions
  - Specific trigger phrases
  - Progressive disclosure (lean SKILL.md, detailed references/)
  - Imperative writing style
  - 1,500-2,000 words for SKILL.md body

### Key Decision Points (Wait for User)

1. After Phase 1: Confirm skill purpose
2. After Phase 3: Approve resource plan
3. After Phase 4: Approve trigger description
4. After Phase 6: Decide whether to iterate

### Quality Standards

Every skill must meet:
- ✅ Description uses third person with specific trigger phrases
- ✅ SKILL.md body is 1,500-2,000 words (under 3,000 max)
- ✅ Writing style is imperative/infinitive form
- ✅ Progressive disclosure implemented (details in references/)
- ✅ All referenced files exist
- ✅ Examples are complete and correct
- ✅ Scripts are executable and documented

---

**Begin with Phase 1: Discovery**
