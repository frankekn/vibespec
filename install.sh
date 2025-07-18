#!/bin/bash
# Vibespec Installation Script
# https://github.com/frankekn/vibespec

set -e # Exit on error
set -u # Exit on undefined variable
set -o pipefail # Exit on pipe failure

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get target directory (default to current directory)
TARGET_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                    VIBESPEC INSTALLER                        ║${NC}"
echo -e "${BLUE}║              Specs-First Workflow for Claude                 ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}🚀 Installing Vibespec to: ${NC}$TARGET_DIR"

# Error handler
error_exit() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
    exit 1
}

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    error_exit "Target directory does not exist: $TARGET_DIR"
fi

# Check if CLAUDE.md exists
if [ -f "$TARGET_DIR/CLAUDE.md" ]; then
    echo -e "${YELLOW}📋 Found existing CLAUDE.md, appending Vibespec workflow rules...${NC}"
    
    # Check if Vibespec rules already exist
    if grep -q "VIBESPEC WORKFLOW RULES" "$TARGET_DIR/CLAUDE.md" 2>/dev/null; then
        echo -e "${YELLOW}⚠️  Vibespec rules already exist in CLAUDE.md, skipping...${NC}"
    else
        # Add two newlines and append workflow rules
        echo "" >> "$TARGET_DIR/CLAUDE.md"
        echo "" >> "$TARGET_DIR/CLAUDE.md"
        cat "$SCRIPT_DIR/workflow-rules.md" >> "$TARGET_DIR/CLAUDE.md"
        echo -e "${GREEN}✅ Workflow rules appended to CLAUDE.md${NC}"
    fi
else
    echo -e "${GREEN}📋 Creating new CLAUDE.md with Vibespec workflow...${NC}"
    cp "$SCRIPT_DIR/CLAUDE.md" "$TARGET_DIR/"
fi

# Always copy/update WORKFLOW.md
echo -e "${GREEN}📄 Installing WORKFLOW.md...${NC}"
cp "$SCRIPT_DIR/WORKFLOW.md" "$TARGET_DIR/"

# Set up .claude directory and hooks
echo -e "${GREEN}⚙️  Setting up Claude hooks...${NC}"
mkdir -p "$TARGET_DIR/.claude/hooks"

# Check if .claude/settings.json exists
if [ -f "$TARGET_DIR/.claude/settings.json" ]; then
    echo -e "${YELLOW}⚠️  Found existing .claude/settings.json${NC}"
    echo -e "${YELLOW}   Please manually merge hooks from:${NC}"
    echo -e "${YELLOW}   $SCRIPT_DIR/.claude/settings.json${NC}"
else
    cp "$SCRIPT_DIR/.claude/settings.json" "$TARGET_DIR/.claude/"
fi

# Copy hook scripts
cp "$SCRIPT_DIR/.claude/hooks/"*.sh "$TARGET_DIR/.claude/hooks/" 2>/dev/null || true

# Make hooks executable
chmod +x "$TARGET_DIR/.claude/hooks/"*.sh 2>/dev/null || true

# Create specs directory
if [ ! -d "$TARGET_DIR/specs" ]; then
    echo -e "${GREEN}📁 Creating specs directory...${NC}"
    mkdir -p "$TARGET_DIR/specs"
fi

# Optional: Copy example specs
echo -e "${YELLOW}❓ Would you like to include example specs? (y/n) ${NC}"
read -p "   " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -d "$SCRIPT_DIR/examples/simple-api/specs/user-auth" ]; then
        echo -e "${GREEN}📝 Copying example specs...${NC}"
        cp -r "$SCRIPT_DIR/examples/simple-api/specs/user-auth" "$TARGET_DIR/specs/example-user-auth"
        echo -e "${GREEN}✅ Example specs added to specs/example-user-auth/${NC}"
    fi
fi

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                   INSTALLATION COMPLETE                      ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}✅ Vibespec installed successfully!${NC}"
echo ""
echo -e "${GREEN}📋 What was installed:${NC}"
echo "   ✓ Enhanced CLAUDE.md with workflow enforcement"
echo "   ✓ WORKFLOW.md with complete process documentation"
echo "   ✓ .claude/hooks/ with blocking enforcement scripts"
echo "   ✓ specs/ directory for your specifications"
echo ""
echo -e "${GREEN}🎯 Test the workflow:${NC}"
echo "   1. cd $TARGET_DIR"
echo "   2. Open in Claude Code"
echo -e "${YELLOW}   3. Say: \"I want to add user authentication\"${NC}"
echo -e "${YELLOW}   4. Claude will enforce the specs-first workflow!${NC}"
echo ""
echo -e "${GREEN}📚 Learn more:${NC}"
echo "   - Read WORKFLOW.md for the complete process"
echo "   - Check specs/ directory for your specifications"
echo "   - Visit https://github.com/frankekn/vibespec"
echo ""
echo -e "${BLUE}🔥 The workflow is now ENFORCED - Claude cannot skip steps!${NC}"