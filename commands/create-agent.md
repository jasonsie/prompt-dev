---
description: Guided agent creation workflow with design, implementation, and validation
argument-hint: Optional agent description
allowed-tools: ["Read", "Write", "Grep", "Glob", "Bash", "Task", "TaskCreate", "TaskUpdate", "AskUserQuestion"]
---

# Agent Creation Workflow

Guide the user through creating a high-quality Claude Code agent from initial concept to validated implementation. Follow a systematic approach: understand requirements, design configuration, create the agent file, validate structure, review quality, and offer to iterate.

## Core Principles

- **Ask clarifying questions**: Identify ambiguities about agent purpose, triggering, tools needed, and model choice
- **Use agent-creator agent**: Leverage the specialized agent for AI-assisted generation
- **Use agent-reviewer agent**: Get quality feedback on generated agents
- **Use plugin-validator agent**: Verify structure and correctness
- **Follow best practices**: Apply patterns from agent-development skill
- **Use TaskCreate/TaskUpdate**: Track progress throughout all phases

**Initial request:** $ARGUMENTS

---

## Phase 1: Discovery

**Goal**: Understand what the agent should do and when it should trigger

**Actions**:
1. Create todo list with all 6 phases using TaskCreate
2. If agent purpose is clear from arguments:
   - Summarize understanding
   - Identify agent type (analysis, generation, review, validation, etc.)
3. If agent purpose is unclear, ask user:
   - What should this agent do?
   - When should it trigger (proactively, on request, or both)?
   - What specific scenarios should trigger it?
   - Any example user requests that should activate it?
4. Summarize understanding and confirm before proceeding

**Output**: Clear statement of agent purpose and triggering scenarios

---

## Phase 2: Design

**Goal**: Determine agent configuration details

**Actions**:
1. Ask user for design decisions (use AskUserQuestion for structured input):
   - **Model choice**: inherit (recommended), sonnet (complex), haiku (simple), opus (advanced)?
   - **Color**: blue/cyan (analysis), green (generation), yellow (validation), red (security), magenta (creative)?
   - **Tools needed**: Which tools does the agent need? (Read, Write, Grep, Glob, Bash, etc.)
   - **Permission mode**: Should it auto-accept edits, operate in plan mode, or use default?
   - **Advanced features needed**:
     - Preload specific skills?
     - Limit max turns to prevent runaway?
     - Scope specific MCP servers to this agent?
     - Attach lifecycle hooks (like SubagentStop validation)?

2. Present recommended configuration and get confirmation

**Output**: Complete agent configuration specification

---

## Phase 3: Create

**Goal**: Generate the agent file using agent-creator

**Actions**:
1. Determine agent file location:
   - Plugin: `agents/[identifier].md`
   - Project: `.claude/agents/[identifier].md` (if supported)
   - Ask user where to create if ambiguous

2. Use Task tool to spawn agent-creator agent:
   - Provide clear description of what agent should do
   - Include triggering scenarios from Phase 1
   - Include configuration from Phase 2
   - Agent-creator will generate: identifier, description with examples, system prompt

3. Wait for agent-creator to complete and create the file

**Output**: Agent file created at specified location

---

## Phase 4: Validate Structure

**Goal**: Ensure agent file is structurally correct

**Actions**:
1. Validate using available tools (in priority order):
   a. Use plugin-validator agent for comprehensive validation
   b. If agent-development skill has validation scripts, use those
   - Frontmatter completeness
   - Naming conventions
   - File structure
   - Example block format

3. Report validation results to user

**Output**: Validation report with any structural issues

---

## Phase 5: Review Quality

**Goal**: Get quality feedback on agent description and system prompt

**Actions**:
1. Use Task tool to spawn agent-reviewer agent:
   - Provide path to the created agent file
   - Agent-reviewer will assess:
     - Description quality (trigger phrases, examples)
     - System prompt completeness
     - Tool selection appropriateness
     - Model choice reasoning

2. Present review findings to user:
   - Critical issues (must fix)
   - Major issues (should fix)
   - Minor suggestions (optional)
   - Positive aspects

3. Ask user: "Agent created and reviewed. Issues found: [count]. Would you like me to fix the issues now, or are you satisfied with the current version?"

**Output**: Quality review with specific recommendations

---

## Phase 6: Iterate (Optional)

**Goal**: Fix issues and improve agent based on feedback

**Actions**:
1. If user wants fixes, address issues by priority:
   - Critical first (blocking problems)
   - Major second (quality improvements)
   - Minor third (nice-to-have enhancements)

2. After fixes, offer to re-review:
   - Run agent-reviewer again
   - Compare before/after
   - Verify improvements

3. Provide final summary:
   - Agent name and location
   - What it does
   - How to test it (example trigger phrases)
   - Next steps (add to plugin, test in Claude Code)

**Output**: Improved agent ready for use

---

## Testing Recommendations

After creation, suggest the user test the agent by:

1. **Install plugin/project** (if not already active):
   ```bash
   cc --plugin-dir /path/to/plugin
   ```

2. **Test triggering** using phrases from the description examples:
   - Ask questions that match the example user requests
   - Verify the agent triggers correctly
   - Check that the agent provides expected functionality

3. **Verify tool access** (if tools were restricted):
   - Ensure agent has necessary tools
   - Confirm it doesn't have excessive access

4. **Check output quality**:
   - Does the agent follow its system prompt?
   - Is the output format correct?
   - Are edge cases handled appropriately?

---

## Important Notes

### Throughout All Phases

- **Use TaskCreate/TaskUpdate** to track progress
- **Load agent-development skill** if needing reference material
- **Use specialized agents** (agent-creator, agent-reviewer, plugin-validator)
- **Ask for confirmation** at key decision points
- **Apply best practices**:
  - 2-4 examples in description
  - Clear trigger phrases
  - Least privilege tool access
  - Appropriate model choice
  - Comprehensive system prompt (500-3,000 words)

### Key Decision Points (Wait for User)

1. After Phase 1: Confirm agent purpose
2. After Phase 2: Approve configuration
3. After Phase 5: Decide whether to iterate

### Quality Standards

Every agent must meet:
- ✅ Identifier follows naming rules (kebab-case, 3-50 chars)
- ✅ Description has 2-4 concrete examples
- ✅ Examples show context, user, assistant, commentary
- ✅ System prompt is comprehensive and structured
- ✅ Model choice is appropriate
- ✅ Tool selection follows least privilege
- ✅ Color matches agent purpose

---

**Begin with Phase 1: Discovery**
