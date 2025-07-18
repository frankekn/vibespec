#!/bin/bash
# Vibespec Remote Installation Script
# Usage: curl -sSL https://raw.githubusercontent.com/frankekn/vibespec/main/remote-install.sh | bash

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get target directory (default to current directory)
TARGET_DIR="${1:-.}"
REPO_URL="https://raw.githubusercontent.com/frankekn/vibespec/main"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              VIBESPEC REMOTE INSTALLER                       ║${NC}"
echo -e "${BLUE}║              Specs-First Workflow for Claude                 ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}🚀 Installing Vibespec to: ${NC}$TARGET_DIR"

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}❌ Error: Target directory does not exist: $TARGET_DIR${NC}"
    exit 1
fi

# Check if curl is available
if ! command -v curl >/dev/null 2>&1; then
    echo -e "${RED}❌ Error: curl is required but not installed${NC}"
    exit 1
fi

# Download and install workflow rules
echo -e "${GREEN}📋 Installing workflow rules...${NC}"
if [ -f "$TARGET_DIR/CLAUDE.md" ]; then
    echo -e "${YELLOW}📋 Found existing CLAUDE.md, appending Vibespec workflow rules...${NC}"
    
    # Check if Vibespec rules already exist
    if grep -q "VIBESPEC WORKFLOW RULES" "$TARGET_DIR/CLAUDE.md" 2>/dev/null; then
        echo -e "${YELLOW}⚠️  Vibespec rules already exist in CLAUDE.md, skipping...${NC}"
    else
        # Add two newlines and append workflow rules
        echo "" >> "$TARGET_DIR/CLAUDE.md"
        echo "" >> "$TARGET_DIR/CLAUDE.md"
        curl -sSL "$REPO_URL/workflow-rules.md" >> "$TARGET_DIR/CLAUDE.md"
        echo -e "${GREEN}✅ Workflow rules appended to CLAUDE.md${NC}"
    fi
else
    echo -e "${GREEN}📋 Creating new CLAUDE.md with Vibespec workflow...${NC}"
    curl -sSL "$REPO_URL/CLAUDE.md" > "$TARGET_DIR/CLAUDE.md"
fi

# Download WORKFLOW.md
echo -e "${GREEN}📄 Installing WORKFLOW.md...${NC}"
curl -sSL "$REPO_URL/WORKFLOW.md" > "$TARGET_DIR/WORKFLOW.md"

# Set up .claude directory and hooks
echo -e "${GREEN}⚙️  Setting up Claude hooks...${NC}"
mkdir -p "$TARGET_DIR/.claude/hooks"

# Download settings.json
if [ -f "$TARGET_DIR/.claude/settings.json" ]; then
    echo -e "${YELLOW}⚠️  Found existing .claude/settings.json${NC}"
    echo -e "${YELLOW}   Please manually merge hooks from the downloaded file${NC}"
    curl -sSL "$REPO_URL/.claude/settings.json" > "$TARGET_DIR/.claude/settings.json.vibespec"
    echo -e "${YELLOW}   Saved as .claude/settings.json.vibespec${NC}"
else
    curl -sSL "$REPO_URL/.claude/settings.json" > "$TARGET_DIR/.claude/settings.json"
fi

# Download hook scripts
echo -e "${GREEN}📥 Downloading hook scripts...${NC}"
curl -sSL "$REPO_URL/.claude/hooks/enforce-specs.sh" > "$TARGET_DIR/.claude/hooks/enforce-specs.sh"
curl -sSL "$REPO_URL/.claude/hooks/check-workflow.sh" > "$TARGET_DIR/.claude/hooks/check-workflow.sh"
curl -sSL "$REPO_URL/.claude/hooks/update-docs.sh" > "$TARGET_DIR/.claude/hooks/update-docs.sh"

# Make hooks executable
chmod +x "$TARGET_DIR/.claude/hooks/"*.sh

# Create specs directory
if [ ! -d "$TARGET_DIR/specs" ]; then
    echo -e "${GREEN}📁 Creating specs directory...${NC}"
    mkdir -p "$TARGET_DIR/specs"
fi

# Optional: Download example specs
echo -e "${YELLOW}❓ Would you like to include example specs? (y/n) ${NC}"
read -p "   " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}📝 Downloading example specs...${NC}"
    mkdir -p "$TARGET_DIR/specs/example-user-auth"
    curl -sSL "$REPO_URL/examples/simple-api/specs/user-auth/requirements.md" > "$TARGET_DIR/specs/example-user-auth/requirements.md"
    curl -sSL "$REPO_URL/examples/simple-api/specs/user-auth/design.md" > "$TARGET_DIR/specs/example-user-auth/design.md"
    curl -sSL "$REPO_URL/examples/simple-api/specs/user-auth/tasks.md" > "$TARGET_DIR/specs/example-user-auth/tasks.md"
    echo -e "${GREEN}✅ Example specs added to specs/example-user-auth/${NC}"
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
echo ""
echo -e "${GREEN}🚀 One-line install command for future use:${NC}"
echo -e "${BLUE}   curl -sSL https://raw.githubusercontent.com/frankekn/vibespec/main/remote-install.sh | bash${NC}"