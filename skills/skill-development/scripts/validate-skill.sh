#!/bin/bash
# Validate Claude Code plugin skill structure and quality

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Usage
if [ $# -eq 0 ]; then
    echo "Usage: $0 <skill-directory>"
    echo "Example: $0 skills/hook-development"
    exit 1
fi

SKILL_DIR="$1"

# Validation counters
ERRORS=0
WARNINGS=0
PASSES=0

error() {
    echo -e "${RED}✗ ERROR:${NC} $1"
    ((ERRORS++))
}

warning() {
    echo -e "${YELLOW}⚠ WARNING:${NC} $1"
    ((WARNINGS++))
}

pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASSES++))
}

echo "Validating skill: $SKILL_DIR"
echo "================================"
echo

# Check 1: Skill directory exists
if [ ! -d "$SKILL_DIR" ]; then
    error "Skill directory does not exist: $SKILL_DIR"
    exit 1
fi
pass "Skill directory exists"

# Check 2: SKILL.md file exists
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
    error "SKILL.md file not found in $SKILL_DIR"
    exit 1
fi
pass "SKILL.md file exists"

# Check 3: YAML frontmatter exists
if ! head -n 1 "$SKILL_DIR/SKILL.md" | grep -q "^---$"; then
    error "SKILL.md missing YAML frontmatter (must start with ---)"
else
    pass "YAML frontmatter present"
fi

# Check 4: Required frontmatter fields
if ! grep -q "^name:" "$SKILL_DIR/SKILL.md"; then
    error "Missing 'name' field in frontmatter"
else
    pass "Frontmatter has 'name' field"
fi

if ! grep -q "^description:" "$SKILL_DIR/SKILL.md"; then
    error "Missing 'description' field in frontmatter"
else
    pass "Frontmatter has 'description' field"
fi

# Check 5: Description uses third person
DESCRIPTION=$(sed -n '/^description:/,/^[a-z]/p' "$SKILL_DIR/SKILL.md" | grep -v "^[a-z]:" | tr -d '\n')
if echo "$DESCRIPTION" | grep -qi "this skill should be used when"; then
    pass "Description uses third person format"
elif echo "$DESCRIPTION" | grep -qi "use this skill when"; then
    warning "Description uses second person (should be: 'This skill should be used when...')"
else
    warning "Description may not follow recommended format"
fi

# Check 6: Description has trigger phrases in quotes
if echo "$DESCRIPTION" | grep -q '"[^"]*"'; then
    pass "Description includes trigger phrases in quotes"
else
    warning "Description should include specific trigger phrases in quotes"
fi

# Check 7: Word count check
WORD_COUNT=$(sed -n '/^---$/,/^---$/!p' "$SKILL_DIR/SKILL.md" | wc -w | tr -d ' ')
if [ "$WORD_COUNT" -lt 1500 ]; then
    warning "SKILL.md body is only $WORD_COUNT words (recommended: 1,500-2,000)"
elif [ "$WORD_COUNT" -gt 3000 ]; then
    warning "SKILL.md body is $WORD_COUNT words (max: 3,000, ideally 1,500-2,000)"
    warning "Consider moving detailed content to references/"
elif [ "$WORD_COUNT" -gt 2000 ]; then
    warning "SKILL.md body is $WORD_COUNT words (acceptable, but ideally 1,500-2,000)"
else
    pass "SKILL.md body length is good ($WORD_COUNT words)"
fi

# Check 8: Check for second person writing
if grep -qi "you should\|you need\|you can\|you must\|you will" "$SKILL_DIR/SKILL.md"; then
    warning "SKILL.md contains second person writing ('you'). Use imperative form instead."
fi

# Check 9: Check for references/ directory
if [ -d "$SKILL_DIR/references" ]; then
    REF_COUNT=$(find "$SKILL_DIR/references" -type f -name "*.md" | wc -l | tr -d ' ')
    pass "references/ directory exists with $REF_COUNT file(s)"

    # Check if references are mentioned in SKILL.md
    if grep -q "references/" "$SKILL_DIR/SKILL.md"; then
        pass "SKILL.md references the references/ directory"
    else
        warning "SKILL.md should mention files in references/ directory"
    fi
else
    if [ "$WORD_COUNT" -gt 2500 ]; then
        warning "No references/ directory (consider creating for word count > 2,500)"
    fi
fi

# Check 10: Check for examples/ directory
if [ -d "$SKILL_DIR/examples" ]; then
    EX_COUNT=$(find "$SKILL_DIR/examples" -type f | wc -l | tr -d ' ')
    pass "examples/ directory exists with $EX_COUNT file(s)"

    # Check if examples are mentioned in SKILL.md
    if grep -q "examples/" "$SKILL_DIR/SKILL.md"; then
        pass "SKILL.md references the examples/ directory"
    else
        warning "SKILL.md should mention files in examples/ directory"
    fi
fi

# Check 11: Check for scripts/ directory
if [ -d "$SKILL_DIR/scripts" ]; then
    SCRIPT_COUNT=$(find "$SKILL_DIR/scripts" -type f \( -name "*.sh" -o -name "*.py" -o -name "*.js" \) | wc -l | tr -d ' ')
    pass "scripts/ directory exists with $SCRIPT_COUNT script(s)"

    # Check if scripts are mentioned in SKILL.md
    if grep -q "scripts/" "$SKILL_DIR/SKILL.md"; then
        pass "SKILL.md references the scripts/ directory"
    else
        warning "SKILL.md should mention scripts in scripts/ directory"
    fi

    # Check script executability
    while IFS= read -r script; do
        if [ ! -x "$script" ]; then
            warning "Script not executable: $(basename "$script")"
        fi
    done < <(find "$SKILL_DIR/scripts" -type f \( -name "*.sh" -o -name "*.py" \))
fi

# Check 12: Verify referenced files exist
echo
echo "Checking referenced files..."
while IFS= read -r ref; then
    # Extract file path from references like `references/file.md` or **`references/file.md`**
    FILE=$(echo "$ref" | sed -E 's/.*`([^`]+)`.*/ \1/')
    if [ ! -f "$SKILL_DIR/$FILE" ]; then
        error "Referenced file does not exist: $FILE"
    fi
done < <(grep -o '`[^`]*\(references\|examples\|scripts\)/[^`]*`' "$SKILL_DIR/SKILL.md" 2>/dev/null || true)

# Summary
echo
echo "================================"
echo "Validation Summary"
echo "================================"
echo -e "${GREEN}✓ Passes:${NC} $PASSES"
echo -e "${YELLOW}⚠ Warnings:${NC} $WARNINGS"
echo -e "${RED}✗ Errors:${NC} $ERRORS"
echo

if [ $ERRORS -gt 0 ]; then
    echo -e "${RED}FAILED:${NC} Skill has $ERRORS error(s)"
    exit 1
elif [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}PASSED WITH WARNINGS:${NC} Skill has $WARNINGS warning(s)"
    exit 0
else
    echo -e "${GREEN}PASSED:${NC} Skill validation successful!"
    exit 0
fi
