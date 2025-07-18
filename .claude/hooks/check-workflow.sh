#!/bin/bash
# Check if workflow is being followed

# Check if WORKFLOW.md exists
if [ ! -f "WORKFLOW.md" ]; then
  echo "⚠️  Missing WORKFLOW.md file!"
  echo "This file defines the development process."
  echo "Run: vibespec/install.sh to set up the workflow"
  exit 0
fi

# Check if Vibespec rules are in CLAUDE.md
if [ -f "CLAUDE.md" ]; then
  if ! grep -q "VIBESPEC WORKFLOW RULES" CLAUDE.md 2>/dev/null; then
    echo "⚠️  Vibespec workflow rules not found in CLAUDE.md"
    echo "The workflow may not be properly enforced."
    exit 0
  fi
fi

# Check if we're editing code without specs
if [[ "$TOOL_PATH" =~ \.(js|jsx|ts|tsx|py|go|java|rs|rb|php|swift|kt|scala|c|cpp|h|hpp|cs)$ ]]; then
  # Try to determine feature name from file path or branch
  FEATURE_CONTEXT=""
  
  # Check current git branch
  if command -v git >/dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null || echo "")
    if [[ "$BRANCH" =~ feature/(.+) ]] || [[ "$BRANCH" =~ feat/(.+) ]]; then
      FEATURE_CONTEXT="${BASH_REMATCH[1]}"
    fi
  fi
  
  if [ -n "$FEATURE_CONTEXT" ] && [ ! -d "specs/$FEATURE_CONTEXT" ]; then
    echo "📋 Reminder: Working on feature '$FEATURE_CONTEXT' without specs?"
    echo "   Consider creating specs/$FEATURE_CONTEXT/ first"
  fi
fi

exit 0