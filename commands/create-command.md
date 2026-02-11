---
description: Guided command creation workflow with design, implementation, and validation
argument-hint: Optional command description
allowed-tools: ["Read", "Write", "Grep", "Glob", "Bash", "Task", "TaskCreate", "TaskUpdate", "AskUserQuestion"]
---

# Command Creation Workflow

Guide the user through creating a high-quality Claude Code slash command from initial concept to validated implementation. Follow a systematic approach: understand requirements, choose format (command vs skill), design configuration, create the file, validate, review, and iterate.

## Core Principles

- **Critical rule**: Commands are instructions FOR Claude, not documentation TO users
- **Choose format wisely**: Simple actions use commands/, complex functionality uses skills/
- **Use command-creator agent**: Leverage specialized agent for AI-assisted generation
- **Use command-reviewer agent**: Get quality feedback on generated commands
- **Follow least privilege**: Minimal tool access needed
- **Use TaskCreate/TaskUpdate**: Track progress throughout all phases

**Initial request:** $ARGUMENTS

---

## Phase 1: Discovery

**Goal**: Understand what the command should do

**Actions**:
1. Create todo list with all 6 phases using TaskCreate
2. If command purpose is clear from arguments:
   - Summarize understanding
   - Identify command type (deployment, analysis, review, workflow, etc.)
3. If command purpose is unclear, ask user:
   - What should this command do when invoked?
   - What arguments will it take?
   - Is this a simple action or complex workflow?
   - Should it run automatically or only when user invokes it?
4. Summarize understanding and confirm before proceeding

**Output**: Clear statement of command purpose and behavior

---

## Phase 2: Choose Format

**Goal**: Determine whether to use commands/ or skills/ directory

**Actions**:
1. Analyze requirements and recommend format:

   **Use commands/*.md when**:
   - Simple, user-initiated action
   - No auto-triggering needed
   - Minimal supporting files
   - Straightforward workflow

   **Use skills/*/SKILL.md when**:
   - Needs auto-triggering based on context
   - Requires bundled resources (references/, examples/, scripts/)
   - Benefits from progressive disclosure
   - Uses advanced features (context: fork, scoped hooks)
   - Complex domain knowledge

2. Present recommendation to user with rationale

3. Get confirmation before proceeding

**Output**: Confirmed format choice (command or skill)

---

## Phase 3: Design

**Goal**: Determine command configuration details

**Actions**:
1. Ask user for design decisions (use AskUserQuestion):
   - **Arguments**: What arguments does it accept? Format?
   - **Tools needed**: Read? Write? Bash (with scope)? Other tools?
   - **Model**: Should it use a specific model? (haiku for fast/simple, sonnet for standard, opus for complex)
   - **Advanced features**:
     - Should it run in a subagent (context: fork)?
     - Need scoped lifecycle hooks?
     - Dynamic bash execution for context?
     - File references for input?

2. Design frontmatter based on choices:
   ```yaml
   ---
   description: [Brief description under 60 chars]
   argument-hint: [arg1] [arg2]
   allowed-tools: Read, Write, Bash(git:*)
   model: sonnet  # if specific model needed
   ---
   ```

3. Present configuration and get confirmation

**Output**: Complete command configuration specification

---

## Phase 4: Create

**Goal**: Generate the command file using command-creator

**Actions**:
1. Determine command file location:
   - Plugin: `commands/[command-name].md`
   - Project: `.claude/commands/[command-name].md`
   - Personal: `~/.claude/commands/[command-name].md`
   - Or if skill format: `skills/[skill-name]/SKILL.md`

2. Use Task tool to spawn command-creator agent:
   - Provide clear description of what command should do
   - Include argument handling from Phase 3
   - Include tool requirements from Phase 3
   - Command-creator will generate the file with frontmatter and instructions

3. Wait for command-creator to complete

**Output**: Command file created at specified location

---

## Phase 5: Review Quality

**Goal**: Ensure command follows best practices

**Actions**:
1. Use Task tool to spawn command-reviewer agent:
   - Provide path to the created command file
   - Agent will assess:
     - **Critical rule**: Instructions are FOR Claude (not documentation TO users)
     - Frontmatter completeness (description, argument-hint, allowed-tools)
     - Tool access follows least privilege
     - Argument handling ($ARGUMENTS, $1, $2, etc.)
     - Plugin portability (${CLAUDE_PLUGIN_ROOT} if plugin command)
     - Command flow and error handling

2. Present review findings to user:
   - Critical issues (must fix)
   - Major issues (should fix)
   - Minor suggestions (optional)
   - Positive aspects

3. Ask user: "Command created and reviewed. Issues found: [count]. Would you like me to fix the issues now?"

**Output**: Quality review with specific recommendations

---

## Phase 6: Iterate (Optional)

**Goal**: Fix issues and improve command based on feedback

**Actions**:
1. If user wants fixes, address issues by priority:
   - Critical first (instructions written as documentation)
   - Major second (tool access, argument handling)
   - Minor third (style improvements)

2. Common fixes:
   - Rewrite user-facing documentation as instructions FOR Claude
   - Narrow tool access to minimum needed
   - Add ${CLAUDE_PLUGIN_ROOT} for plugin file references
   - Improve argument validation and error handling
   - Add dynamic features ($ARGUMENTS, @files, !`bash`)

3. After fixes, offer to re-review:
   - Run command-reviewer again
   - Verify improvements
   - Confirm issues resolved

4. Provide final summary:
   - Command name and location
   - How to invoke it (`/command-name [args]`)
   - What it does
   - Next steps (test in Claude Code)

**Output**: Improved command ready for use

---

## Testing Recommendations

After creation, suggest the user test the command by:

1. **Install plugin/project**:
   ```bash
   cc --plugin-dir /path/to/plugin
   ```

2. **Verify command appears**:
   - Type `/` and look for command in menu
   - Check description is clear

3. **Test execution**:
   - Run `/command-name` with various arguments
   - Verify tool access is sufficient
   - Check error handling for missing/invalid arguments
   - Confirm output format is as expected

4. **Test dynamic features** (if used):
   - File references (@path) load correctly
   - Bash execution (!`command`) provides expected context
   - Plugin paths (${CLAUDE_PLUGIN_ROOT}) resolve correctly

---

## Important Notes

### Throughout All Phases

- **Use TaskCreate/TaskUpdate** to track progress
- **Load command-development skill** if needing reference material
- **Use specialized agents** (command-creator, command-reviewer, plugin-validator)
- **Ask for confirmation** at key decision points
- **Critical rule**: Instructions FOR Claude, not TO users
- **Apply best practices**:
  - Clear, concise description (< 60 chars)
  - Document arguments with argument-hint
  - Minimal tool access (least privilege)
  - ${CLAUDE_PLUGIN_ROOT} for plugin portability
  - Proper argument handling

### Key Decision Points (Wait for User)

1. After Phase 1: Confirm command purpose
2. After Phase 2: Confirm format choice (command vs skill)
3. After Phase 3: Approve configuration
4. After Phase 5: Decide whether to iterate

### Quality Standards

Every command must meet:
- ✅ Instructions are FOR Claude (not user documentation)
- ✅ Frontmatter has description and argument-hint (if args used)
- ✅ allowed-tools follows least privilege
- ✅ ${CLAUDE_PLUGIN_ROOT} used for plugin file paths
- ✅ Argument handling is correct ($1, $ARGUMENTS, @files)
- ✅ Clear step-by-step workflow

---

**Begin with Phase 1: Discovery**
