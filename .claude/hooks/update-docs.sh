#!/bin/bash
# Documentation update reminder

# Only remind for source file changes
if [[ "$TOOL_PATH" =~ \.(js|jsx|ts|tsx|py|go|java|rs|rb|php|swift|kt|scala|c|cpp|h|hpp|cs)$ ]]; then
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
  
  echo "📝 Documentation Update Reminder"
  echo ""
  echo "You've modified: $TOOL_PATH"
  
  if [ -n "$FILE_TYPE" ]; then
    echo "Type: $FILE_TYPE changes detected"
  fi
  
  echo ""
  echo "Consider updating:"
  echo "- README.md - if this adds new features or changes setup"
  echo "- API docs - if endpoints were added/modified"
  echo "- Configuration docs - if new settings were added"
  echo "- Examples - if this enables new use cases"
  echo "- specs/{feature}/summary.md - to document decisions"
fi

exit 0