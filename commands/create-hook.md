---
description: Guided hook creation workflow with event selection, security, and validation
argument-hint: Optional hook description
allowed-tools: ["Read", "Write", "Grep", "Glob", "Bash", "Task", "TaskCreate", "TaskUpdate", "AskUserQuestion"]
---

# Hook Creation Workflow

Guide the user through creating secure, reliable Claude Code hooks from initial concept to validated implementation. Follow a systematic approach: understand requirements, select event and type, design configuration, create files, validate schema, review security, and iterate.

## Core Principles

- **Security first**: Always validate inputs, quote variables, handle errors
- **Choose appropriate type**: command (fast/deterministic), prompt (context-aware), agent (complex)
- **Use hook-creator agent**: Leverage specialized agent for AI-assisted generation
- **Use hook-reviewer agent**: Get security and quality feedback
- **Prefer prompt-based**: For most validation use cases
- **Use TaskCreate/TaskUpdate**: Track progress throughout all phases

**Initial request:** $ARGUMENTS

---

## Phase 1: Discovery

**Goal**: Understand what the hook should detect, prevent, or automate

**Actions**:
1. Create todo list with all 6 phases using TaskCreate
2. If hook purpose is clear from arguments:
   - Summarize understanding
   - Identify hook category (validation, automation, notification, context loading)
3. If hook purpose is unclear, ask user:
   - What should this hook detect or prevent?
   - What event triggers this behavior?
   - Should it block operations, provide feedback, or both?
   - Any specific scenarios to handle?
4. Summarize understanding and confirm before proceeding

**Output**: Clear statement of hook purpose and behavior

---

## Phase 2: Event & Type Selection

**Goal**: Choose the right event and hook type

**Actions**:
1. **Select Event** based on purpose:

   | Purpose | Event | When |
   |---------|-------|------|
   | Validate/block tool calls | PreToolUse | Before tool runs |
   | React to results | PostToolUse | After tool completes |
   | Handle failures | PostToolUseFailure | Tool fails |
   | Add context to prompts | UserPromptSubmit | User sends prompt |
   | Auto-resolve permissions | PermissionRequest | Permission shown |
   | Verify task completion | Stop | Agent stopping |
   | Validate subagent output | SubagentStop | Subagent done |
   | Inject subagent context | SubagentStart | Subagent spawns |
   | Load project context | SessionStart | Session begins |
   | Cleanup/logging | SessionEnd | Session ends |

2. **Choose Hook Type**:
   - **prompt**: LLM-driven, context-aware (recommended for most validation)
   - **command**: Fast bash script, deterministic checks
   - **agent**: Agentic with tool access (for complex validation needing file reads)

3. **Design Matcher**: What tools/events to match
   - Specific: `"Write"`, `"Bash"`
   - Multiple: `"Write|Edit"`, `"Read|Write|Edit"`
   - Wildcard: `"*"` (use sparingly)
   - Regex: `"mcp__.*"` for MCP tools

4. Present recommendations and get user confirmation

**Output**: Confirmed event, type, and matcher pattern

---

## Phase 3: Design Configuration

**Goal**: Specify hook behavior and validation logic

**Actions**:
1. Ask user for hook behavior details (use AskUserQuestion):
   - **For PreToolUse**: Should it approve, deny, or modify operations? What criteria?
   - **For prompt hooks**: What should the LLM evaluate?
   - **For command hooks**: What should the script check?
   - **For Stop/SubagentStop**: What completion criteria to verify?
   - **Timeout**: How long should validation take? (10-60s command, 15-30s prompt, 60-120s agent)

2. **For command hooks**, plan script security:
   - Input validation required
   - Variables to quote
   - Exit code logic (0=success, 2=block)
   - JSON output format

3. Present planned configuration

**Output**: Complete hook specification with validation logic

---

## Phase 4: Create Hook Files

**Goal**: Generate hooks.json and scripts using hook-creator

**Actions**:
1. Determine hook location:
   - Plugin: `hooks/hooks.json` (uses wrapper format)
   - Settings: `.claude/settings.json` (direct format)
   - Ask user if ambiguous

2. Check if hooks.json already exists:
   - If exists: Read current content, plan to merge
   - If new: Create from scratch

3. Use Task tool to spawn hook-creator agent:
   - Provide hook purpose from Phase 1
   - Include event, type, matcher from Phase 2
   - Include validation logic from Phase 3
   - Hook-creator will generate configuration + scripts

4. Wait for hook-creator to complete

**Output**: hooks.json (or updated) and any script files created

---

## Phase 5: Validate Schema & Security

**Goal**: Ensure hooks are correct and secure

**Actions**:
1. **Validate Schema**:
   - Check if validate-hook-schema.sh exists
   - If available: `bash scripts/validate-hook-schema.sh hooks/hooks.json`
   - Otherwise use plugin-validator agent to check structure

2. **Review Security** using hook-reviewer agent:
   - Use Task tool to spawn hook-reviewer agent
   - Agent will assess:
     - JSON schema correctness
     - Matcher pattern validity
     - Script security (input validation, variable quoting, path safety)
     - Timeout appropriateness
     - Exit code handling
     - Hook type selection

3. Present findings to user:
   - Critical issues (security vulnerabilities, schema errors)
   - Major issues (poor practices, performance concerns)
   - Minor suggestions (improvements)
   - Positive aspects

4. Ask user: "Hook created and reviewed. Issues found: [count]. Would you like me to fix the issues now?"

**Output**: Validation and security review reports

---

## Phase 6: Iterate (Optional)

**Goal**: Fix security issues and improve hook quality

**Actions**:
1. If user wants fixes, address by priority:
   - Critical first (security issues, schema errors)
   - Major second (matcher improvements, timeout adjustments)
   - Minor third (code quality, documentation)

2. Common fixes:
   - Add input validation to scripts
   - Quote all bash variables
   - Add path traversal checks
   - Set appropriate timeouts
   - Improve error messages
   - Add ${CLAUDE_PLUGIN_ROOT} for portability

3. After fixes, offer to re-review:
   - Run hook-reviewer again
   - Re-validate schema
   - Confirm security issues resolved

4. Provide final summary:
   - Hook event and type
   - Files created
   - How to test it
   - Important notes about activation

**Output**: Secure, validated hook ready for use

---

## Testing Recommendations

After creation, suggest the user test the hook by:

1. **IMPORTANT**: Restart Claude Code:
   ```bash
   # Hooks load at session start only
   # Exit current session and restart
   cc --debug  # Use debug mode to see hook execution
   ```

2. **Test hook activation**:
   - Trigger the event that should activate the hook
   - Look for hook execution in debug output
   - Verify hook behavior (approve/deny/modify)

3. **Test edge cases**:
   - Missing inputs
   - Invalid data
   - Timeout scenarios
   - Concurrent hook execution (hooks run in parallel)

4. **Verify security**:
   - Try path traversal attempts (should block)
   - Test with special characters in inputs
   - Confirm sensitive data isn't logged

---

## Important Notes

### Throughout All Phases

- **Use TaskCreate/TaskUpdate** to track progress
- **Load hook-development skill** if needing reference material
- **Use specialized agents** (hook-creator, hook-reviewer, plugin-validator)
- **Ask for confirmation** at key decision points
- **Security is critical**: Never skip security review
- **Apply best practices**:
  - Prefer prompt-based hooks for context-aware validation
  - Use command hooks for fast, deterministic checks
  - Always validate inputs in command hooks
  - Quote all bash variables
  - Set appropriate timeouts
  - Use ${CLAUDE_PLUGIN_ROOT} for portability

### Key Decision Points (Wait for User)

1. After Phase 1: Confirm hook purpose
2. After Phase 2: Approve event and type selection
3. After Phase 3: Approve configuration
4. After Phase 5: Decide whether to iterate

### Quality Standards

Every hook must meet:
- ✅ Valid JSON schema (plugin format for hooks.json)
- ✅ Appropriate event selection
- ✅ Correct hook type for use case
- ✅ Security best practices (input validation, quoting, timeouts)
- ✅ Proper exit codes (0=success, 2=block)
- ✅ ${CLAUDE_PLUGIN_ROOT} for all script paths
- ✅ No hardcoded credentials or secrets

### Critical Security Rules

**For command hooks**:
- Always validate all inputs from JSON
- Quote all bash variables (`"$var"` not `$var`)
- Check for path traversal (`..`)
- Use `set -euo pipefail` at script start
- Handle missing fields gracefully
- Don't log sensitive data

---

**Begin with Phase 1: Discovery**
