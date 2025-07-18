#!/bin/bash
# Test script to verify Vibespec workflow enforcement

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                 VIBESPEC WORKFLOW TESTER                     ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Create a test directory
TEST_DIR="vibespec-test"
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

echo -e "${GREEN}📁 Created test directory: $TEST_DIR${NC}"

# Install Vibespec
echo -e "${GREEN}🚀 Installing Vibespec...${NC}"
../install.sh .

echo ""
echo -e "${BLUE}🧪 RUNNING WORKFLOW TESTS${NC}"
echo ""

# Test 1: Check if hooks are executable
echo -e "${YELLOW}Test 1: Hook executability${NC}"
if [ -x ".claude/hooks/enforce-specs.sh" ] && [ -x ".claude/hooks/check-workflow.sh" ]; then
    echo -e "${GREEN}✅ Hooks are executable${NC}"
else
    echo -e "${RED}❌ Hooks are not executable${NC}"
    exit 1
fi

# Test 2: Check if CLAUDE.md has workflow rules
echo -e "${YELLOW}Test 2: CLAUDE.md workflow rules${NC}"
if grep -q "VIBESPEC WORKFLOW RULES" CLAUDE.md; then
    echo -e "${GREEN}✅ Workflow rules found in CLAUDE.md${NC}"
else
    echo -e "${RED}❌ Workflow rules not found in CLAUDE.md${NC}"
    exit 1
fi

# Test 3: Check if specs directory exists
echo -e "${YELLOW}Test 3: Specs directory${NC}"
if [ -d "specs" ]; then
    echo -e "${GREEN}✅ Specs directory created${NC}"
else
    echo -e "${RED}❌ Specs directory not found${NC}"
    exit 1
fi

# Test 4: Simulate hook execution for feature request
echo -e "${YELLOW}Test 4: Hook execution simulation${NC}"
export USER_PROMPT="I want to add user authentication feature"
if .claude/hooks/enforce-specs.sh; then
    echo -e "${RED}❌ Hook should have blocked this request${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Hook correctly blocked feature request without specs${NC}"
fi

# Test 5: Test bypass mechanism
echo -e "${YELLOW}Test 5: Bypass mechanism${NC}"
export USER_PROMPT="Emergency bypass for critical bug"
if .claude/hooks/enforce-specs.sh; then
    echo -e "${GREEN}✅ Bypass mechanism works${NC}"
else
    echo -e "${RED}❌ Bypass mechanism failed${NC}"
    exit 1
fi

# Test 6: Create incomplete specs and test blocking
echo -e "${YELLOW}Test 6: Incomplete specs blocking${NC}"
mkdir -p specs/test-feature
echo "# Test requirements" > specs/test-feature/requirements.md
export TOOL_PATH="src/test.js"
if .claude/hooks/check-workflow.sh; then
    echo -e "${RED}❌ Hook should have blocked coding with incomplete specs${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Hook correctly blocked coding with incomplete specs${NC}"
fi

# Test 7: Complete specs should allow coding
echo -e "${YELLOW}Test 7: Complete specs allowing coding${NC}"
echo "# Test design" > specs/test-feature/design.md
echo "# Test tasks" > specs/test-feature/tasks.md
export TOOL_PATH="src/test.js"
if .claude/hooks/check-workflow.sh; then
    echo -e "${GREEN}✅ Hook allows coding with complete specs${NC}"
else
    echo -e "${RED}❌ Hook blocked coding even with complete specs${NC}"
    exit 1
fi

# Test 8: Check settings.json structure
echo -e "${YELLOW}Test 8: Settings.json structure${NC}"
if [ -f ".claude/settings.json" ] && grep -q "UserPromptSubmit" .claude/settings.json; then
    echo -e "${GREEN}✅ Settings.json has correct hook configuration${NC}"
else
    echo -e "${RED}❌ Settings.json missing or incorrect${NC}"
    exit 1
fi

# Cleanup
cd ..
rm -rf "$TEST_DIR"

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                    ALL TESTS PASSED                         ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}✅ Vibespec workflow enforcement is working correctly!${NC}"
echo ""
echo -e "${GREEN}🎯 Ready for production use:${NC}"
echo "   - Installation works"
echo "   - Hooks are executable"
echo "   - Workflow rules are enforced"
echo "   - Bypass mechanism works"
echo "   - Spec validation works"
echo "   - Complete workflow allows coding"
echo ""
echo -e "${BLUE}🔥 Claude Code will now enforce the specs-first workflow!${NC}"