#!/bin/bash
# Check if workflow is being followed - BLOCKING VERSION

# Exit on any error
set -e
set -o pipefail

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
  
  # Skip if editing spec files
  if [[ "$TOOL_PATH" =~ specs/ ]]; then
    exit 0
  fi
  
  # Skip if it's a test file
  if [[ "$TOOL_PATH" =~ (test|spec|__tests__|\.test\.|\.spec\.) ]]; then
    exit 0
  fi
  
  # Try to determine feature name from file path or branch
  FEATURE_CONTEXT=""
  
  # Check current git branch
  if command -v git >/dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null || echo "")
    if [[ "$BRANCH" =~ feature/(.+) ]] || [[ "$BRANCH" =~ feat/(.+) ]]; then
      FEATURE_CONTEXT="${BASH_REMATCH[1]}"
    fi
  fi
  
  # Check if any specs exist
  if [ ! -d "specs" ] || [ -z "$(ls -A specs/ 2>/dev/null)" ]; then
    echo "🛑 CODING WITHOUT SPECS DETECTED"
    echo "❌ Cannot edit code files without approved specifications"
    echo "📋 Create specs/{feature}/requirements.md first"
    echo "📋 Follow the Vibespec workflow before coding"
    exit 1
  fi
  
  # If we have a feature context, check if specs exist for it
  if [ -n "$FEATURE_CONTEXT" ] && [ ! -d "specs/$FEATURE_CONTEXT" ]; then
    echo "🛑 FEATURE BRANCH WITHOUT SPECS"
    echo "❌ Working on feature '$FEATURE_CONTEXT' without specifications"
    echo "📋 Create specs/$FEATURE_CONTEXT/requirements.md first"
    echo "📋 Follow the Vibespec workflow before coding"
    exit 1
  fi
  
  # Check if there are incomplete specs
  if [ -d "specs" ]; then
    # Use find to get all subdirectories in specs/
    for spec_dir in $(find specs -mindepth 1 -maxdepth 1 -type d); do
        feature_name=$(basename "$spec_dir")
        
        # Check if all required files exist
        if [ ! -f "$spec_dir/requirements.md" ]; then
          echo "🛑 INCOMPLETE SPECS: $feature_name"
          echo "❌ Missing requirements.md for feature '$feature_name'"
          echo "📋 Complete specs/$feature_name/requirements.md first"
          exit 1
        fi
        
        if [ ! -f "$spec_dir/design.md" ]; then
          echo "🛑 INCOMPLETE SPECS: $feature_name"
          echo "❌ Missing design.md for feature '$feature_name'"
          echo "📋 Complete specs/$feature_name/design.md first"
          exit 1
        fi
        
        if [ ! -f "$spec_dir/tasks.md" ]; then
          echo "🛑 INCOMPLETE SPECS: $feature_name"
          echo "❌ Missing tasks.md for feature '$feature_name'"
          echo "📋 Complete specs/$feature_name/tasks.md first"
          exit 1
        fi
    done
  fi
fi

exit 0