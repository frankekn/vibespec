#!/bin/bash
# Documentation update reminder and workflow compliance check

# Exit on any error
set -e
set -o pipefail

# Only process source file changes
if [[ "$TOOL_PATH" =~ \.(js|jsx|ts|tsx|py|go|java|rs|rb|php|swift|kt|scala|c|cpp|h|hpp|cs)$ ]]; then
  
  # Skip if editing spec files or test files
  if [[ "$TOOL_PATH" =~ specs/ ]] || [[ "$TOOL_PATH" =~ (test|spec|__tests__|\.test\.|\.spec\.) ]]; then
    exit 0
  fi
  
  # Check if this code change has corresponding specs
  SPEC_FOUND=false
  if [ -d "specs" ]; then
    # Use find to get all subdirectories in specs/
    while IFS= read -r spec_dir; do
      # Check if all required spec files exist
      if [ -f "$spec_dir/requirements.md" ] && [ -f "$spec_dir/design.md" ] && [ -f "$spec_dir/tasks.md" ]; then
        SPEC_FOUND=true
        break
      fi
    done < <(find specs -mindepth 1 -maxdepth 1 -type d 2>/dev/null || true)
  fi
  
  if [ "$SPEC_FOUND" = false ]; then
    echo "🛑 WORKFLOW VIOLATION DETECTED"
    echo "❌ Code changes made without corresponding specifications"
    echo "📋 This violates the Vibespec workflow"
    echo ""
    echo "REQUIRED: Create specs before coding:"
    echo "1. specs/{feature}/requirements.md"
    echo "2. specs/{feature}/design.md"
    echo "3. specs/{feature}/tasks.md"
    echo ""
    echo "🔄 Please create specifications for your changes"
    exit 1
  fi
  
  # Check what type of file was modified
  FILE_TYPE=""
  
  case "$TOOL_PATH" in
    */api/* | */routes/* | */controllers/* | */endpoints/*)
      FILE_TYPE="API"
      ;;
    */models/* | */schemas/* | */entities/*)
      FILE_TYPE="Data Model"
      ;;
    */config/* | */settings/*)
      FILE_TYPE="Configuration"
      ;;
    */components/* | */views/* | */pages/*)
      FILE_TYPE="UI Component"
      ;;
  esac
  
  echo "📝 Vibespec Documentation Update Reminder"
  echo ""
  echo "✅ Code change detected: $TOOL_PATH"
  
  if [ -n "$FILE_TYPE" ]; then
    echo "✅ Type: $FILE_TYPE changes detected"
  fi
  
  echo ""
  echo "📋 Update the following:"
  echo "✓ Update corresponding tasks.md checkboxes"
  echo "✓ Document any design decisions in specs/{feature}/design.md"
  echo "✓ Consider updating README.md if this adds new features"
  echo "✓ Update API docs if endpoints were added/modified"
  echo "✓ Create specs/{feature}/summary.md when feature is complete"
  echo ""
  echo "🔄 This ensures your specs stay current with implementation"
fi

exit 0