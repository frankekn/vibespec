#!/bin/bash
# Enforce specs-first development

# Check if user is asking to add/implement features
if [[ "$USER_PROMPT" =~ (add|implement|create|build|develop|make).*(feature|functionality|component|system|api|endpoint) ]]; then
  echo "📋 Vibespec Reminder: Follow the specs-first workflow!"
  echo ""
  echo "1. First, clarify requirements"
  echo "2. Create specs/{feature}/requirements.md"
  echo "3. Design the solution in design.md"
  echo "4. Plan tasks in tasks.md"
  echo "5. Then implement"
  echo ""
  echo "This ensures quality and clear communication."
fi

exit 0