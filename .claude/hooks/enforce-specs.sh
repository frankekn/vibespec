#!/bin/bash
# Enforce specs-first development - BLOCKING VERSION

# Check if user is asking to add/implement features
if [[ "$USER_PROMPT" =~ (add|implement|create|build|develop|make).*(feature|functionality|component|system|api|endpoint) ]]; then
  
  # Check for bypass keywords
  if [[ "$USER_PROMPT" =~ (emergency|bypass|debug|hotfix|skip workflow) ]]; then
    echo "⚠️  Vibespec workflow bypassed for emergency/debug mode"
    exit 0
  fi
  
  echo "🛑 VIBESPEC WORKFLOW ENFORCEMENT"
  echo ""
  echo "❌ Cannot proceed without following specs-first workflow!"
  echo ""
  echo "REQUIRED SEQUENCE:"
  echo "1. Clarify requirements first"
  echo "2. Create specs/{feature}/requirements.md"
  echo "3. Wait for approval"
  echo "4. Create design.md"
  echo "5. Wait for approval"
  echo "6. Create tasks.md"
  echo "7. Wait for approval"
  echo "8. THEN implement"
  echo ""
  echo "📋 Claude: I must follow the Vibespec workflow. Let me start by understanding your requirements first."
  echo ""
  exit 1  # Block the action
fi

# Check if trying to code without specs
if [[ "$USER_PROMPT" =~ (code|implement|start|begin).*(coding|development|implementation) ]]; then
  
  # Check if specs directory exists
  if [ ! -d "specs" ]; then
    echo "🛑 NO SPECS FOUND"
    echo "❌ Cannot start coding without approved specifications"
    echo "📋 Create specs/{feature}/requirements.md first"
    exit 1
  fi
  
  # Check if there are any spec files
  if [ ! -f specs/*/requirements.md ]; then
    echo "🛑 NO REQUIREMENTS FOUND"
    echo "❌ Cannot start coding without approved requirements.md"
    echo "📋 Create specs/{feature}/requirements.md first"
    exit 1
  fi
  
  # Check if design.md exists
  if [ ! -f specs/*/design.md ]; then
    echo "🛑 NO DESIGN FOUND"
    echo "❌ Cannot start coding without approved design.md"
    echo "📋 Create specs/{feature}/design.md first"
    exit 1
  fi
  
  # Check if tasks.md exists
  if [ ! -f specs/*/tasks.md ]; then
    echo "🛑 NO TASKS FOUND"
    echo "❌ Cannot start coding without approved tasks.md"
    echo "📋 Create specs/{feature}/tasks.md first"
    exit 1
  fi
  
fi

exit 0