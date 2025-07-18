#!/bin/bash
# Vibespec Installation Script
# https://github.com/frankekn/vibespec

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get target directory (default to current directory)
TARGET_DIR="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo -e "${GREEN}🚀 Installing Vibespec to: ${NC}$TARGET_DIR"

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}❌ Error: Target directory does not exist: $TARGET_DIR${NC}"
    exit 1
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
read -p "Would you like to include example specs? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -d "$SCRIPT_DIR/examples/simple-api/specs/user-auth" ]; then
        echo -e "${GREEN}📝 Copying example specs...${NC}"
        cp -r "$SCRIPT_DIR/examples/simple-api/specs/user-auth" "$TARGET_DIR/specs/example-user-auth"
        echo -e "${GREEN}✅ Example specs added to specs/example-user-auth/${NC}"
    fi
fi

echo ""
echo -e "${GREEN}✅ Vibespec installed successfully!${NC}"
echo ""
echo -e "${GREEN}📋 Next steps:${NC}"
echo "   1. cd $TARGET_DIR"
echo "   2. Open in Claude Code"
echo "   3. Claude will automatically follow the Vibespec workflow"
echo ""
echo -e "${GREEN}🎯 Try it out:${NC}"
echo "   Say: \"I want to add user authentication\""
echo "   Claude will create specs first, following the workflow!"
echo ""
echo -e "${GREEN}📚 For more information:${NC}"
echo "   - Read WORKFLOW.md for the complete process"
echo "   - Check specs/ directory for your specifications"
echo "   - Visit https://github.com/frankekn/vibespec"