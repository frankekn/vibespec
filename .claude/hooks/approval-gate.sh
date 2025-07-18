#!/bin/bash
# Approval gate enforcement for Vibespec workflow

# Exit on any error
set -e
set -o pipefail

# This hook checks if the user has approved the previous step before allowing the next step

# Extract the current workflow step from the user prompt
CURRENT_STEP=""
if [[ "$USER_PROMPT" =~ (create|write|make).*design\.md ]]; then
    CURRENT_STEP="design"
elif [[ "$USER_PROMPT" =~ (create|write|make).*tasks\.md ]]; then
    CURRENT_STEP="tasks"
elif [[ "$USER_PROMPT" =~ (implement|code|start|begin) ]]; then
    CURRENT_STEP="implementation"
fi

# Check if we're trying to proceed to the next step
if [ -n "$CURRENT_STEP" ]; then
    
    # Check for approval keywords in the conversation
    # Note: This is a simplified check - in real implementation, 
    # Claude Code would need to track conversation history
    
    case "$CURRENT_STEP" in
        "design")
            # Check if requirements.md exists
            if ! find specs -name "requirements.md" -type f 2>/dev/null | grep -q .; then
                echo "🛑 APPROVAL GATE: DESIGN STEP"
                echo "❌ Cannot create design.md without approved requirements.md"
                echo "📋 Create and get approval for requirements.md first"
                exit 1
            fi
            
            # Check if user has approved requirements
            if [[ ! "$USER_PROMPT" =~ (approve|approved|looks good|proceed|continue|next) ]]; then
                echo "⏳ APPROVAL GATE: Waiting for requirements approval"
                echo "❌ Please review and approve requirements.md before proceeding to design.md"
                echo "📋 Say something like: 'Requirements approved, proceed to design'"
                exit 1
            fi
            ;;
            
        "tasks")
            # Check if design.md exists
            if ! find specs -name "design.md" -type f 2>/dev/null | grep -q .; then
                echo "🛑 APPROVAL GATE: TASKS STEP"
                echo "❌ Cannot create tasks.md without approved design.md"
                echo "📋 Create and get approval for design.md first"
                exit 1
            fi
            
            # Check if user has approved design
            if [[ ! "$USER_PROMPT" =~ (approve|approved|looks good|proceed|continue|next) ]]; then
                echo "⏳ APPROVAL GATE: Waiting for design approval"
                echo "❌ Please review and approve design.md before proceeding to tasks.md"
                echo "📋 Say something like: 'Design approved, proceed to tasks'"
                exit 1
            fi
            ;;
            
        "implementation")
            # Check if all spec files exist
            has_requirements=$(find specs -name "requirements.md" -type f 2>/dev/null | grep -c . || echo 0)
            has_design=$(find specs -name "design.md" -type f 2>/dev/null | grep -c . || echo 0)
            has_tasks=$(find specs -name "tasks.md" -type f 2>/dev/null | grep -c . || echo 0)
            
            if [ "$has_requirements" -eq 0 ] || [ "$has_design" -eq 0 ] || [ "$has_tasks" -eq 0 ]; then
                echo "🛑 APPROVAL GATE: IMPLEMENTATION STEP"
                echo "❌ Cannot start implementation without complete specifications"
                echo "📋 All spec files (requirements.md, design.md, tasks.md) must exist and be approved"
                exit 1
            fi
            
            # Check if user has approved tasks
            if [[ ! "$USER_PROMPT" =~ (approve|approved|looks good|proceed|continue|implement|start) ]]; then
                echo "⏳ APPROVAL GATE: Waiting for tasks approval"
                echo "❌ Please review and approve tasks.md before starting implementation"
                echo "📋 Say something like: 'Tasks approved, start implementation'"
                exit 1
            fi
            ;;
    esac
fi

exit 0