# Customization Guide

This guide explains how to adapt Vibespec to your project's specific needs while maintaining the core specs-first workflow.

## Overview

Vibespec is designed to be flexible. While the core workflow (Requirements → Design → Tasks → Code) remains constant, you can customize many aspects to fit your team's needs.

## Quick Customizations

### 1. Workflow Flexibility Levels

#### Strict Mode (Default)
All features require complete specs:
```bash
# Current default behavior
- Requirements.md required
- Design.md required  
- Tasks.md required
- Approval gates enforced
```

#### Relaxed Mode
For smaller teams or projects:
```bash
# Edit .claude/hooks/enforce-specs.sh
# Add size detection:
if [[ "$USER_PROMPT" =~ (minor|small|quick|simple) ]]; then
    echo "📋 Minor change detected - simplified specs allowed"
    # Only require requirements.md
fi
```

#### Minimal Mode
For prototypes or experiments:
```bash
# Create .vibespec/config.json
{
  "mode": "minimal",
  "requireSpecs": ["requirements.md"],
  "enforceApprovals": false
}
```

### 2. Custom Workflow Patterns

#### Feature-Type Based Workflows

Create different workflows for different feature types:

```bash
# In enforce-specs.sh, add:
case "$USER_PROMPT" in
  *"bug fix"*)
    echo "🐛 Bug fix workflow - minimal specs required"
    # Only check for requirements.md with bug description
    ;;
  *"refactor"*)
    echo "🔧 Refactor workflow - design.md required"
    # Skip requirements, focus on design
    ;;
  *"new feature"*)
    echo "✨ Feature workflow - full specs required"
    # Enforce all three files
    ;;
esac
```

#### Team-Size Adaptations

```bash
# For solo developers
{
  "workflow": {
    "autoApprove": true,
    "allowSelfApproval": true,
    "simplifiedDocs": true
  }
}

# For large teams
{
  "workflow": {
    "requireReviewer": true,
    "enforceCheckpoints": true,
    "detailedSpecs": true
  }
}
```

## Advanced Customizations

### 1. Custom EARS Templates

Modify the requirements format in CLAUDE.md:

```markdown
### Custom Requirements Format
Instead of standard EARS, use your format:

**Story Format**:
As a [user type]
I want [functionality]
So that [business value]

**Given-When-Then Format**:
Given [context]
When [action]
Then [expected outcome]
```

### 2. Hook Customization

#### Add Project-Specific Checks

Create `.claude/hooks/custom-checks.sh`:

```bash
#!/bin/bash
# Custom project checks

# Check for security considerations in auth features
if [[ "$USER_PROMPT" =~ (auth|security|login) ]]; then
  if ! grep -q "Security" specs/*/design.md 2>/dev/null; then
    echo "🔒 Security section required in design.md for auth features"
    exit 1
  fi
fi

# Require performance metrics for API changes
if [[ "$TOOL_PATH" =~ api/ ]]; then
  if ! grep -q "Performance" specs/*/requirements.md 2>/dev/null; then
    echo "⚡ Performance requirements needed for API changes"
    exit 1
  fi
fi
```

#### Modify Enforcement Patterns

Edit `.claude/settings.json`:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        // Only enforce for major features
        "matcher": ".*(?:major|significant|critical).*(?:feature|change).*",
        "hooks": [...]
      },
      {
        // Custom patterns for your domain
        "matcher": ".*(?:payment|billing|subscription).*",
        "hooks": [
          {
            "type": "command",
            "command": "./.claude/hooks/financial-checks.sh"
          }
        ]
      }
    ]
  }
}
```

### 3. Workflow Steps Customization

#### Add Custom Steps

Modify WORKFLOW.md to add steps:

```markdown
## The 8-Step Process (Customized)

1. Understand & Clarify
2. Stakeholder Review (NEW)
3. Create Requirements
4. Security Assessment (NEW)
5. Design Solution
6. Architecture Review (NEW)
7. Plan Tasks
8. Implement
```

Update CLAUDE.md to enforce new steps:

```markdown
### MANDATORY: Extended Workflow

1. Requirements gathering
2. **⏳ STAKEHOLDER REVIEW**: Get business approval
3. Technical requirements
4. **⏳ SECURITY REVIEW**: Security team approval
5. Continue with standard flow...
```

### 4. Directory Structure Options

#### Monorepo Structure
```bash
specs/
├── frontend/
│   └── feature-name/
│       ├── requirements.md
│       ├── design.md
│       └── tasks.md
├── backend/
│   └── feature-name/
└── shared/
    └── feature-name/
```

#### Date-Based Structure
```bash
specs/
├── 2024-q1/
│   └── feature-name/
├── 2024-q2/
│   └── feature-name/
```

#### Priority-Based Structure
```bash
specs/
├── critical/
│   └── feature-name/
├── high/
│   └── feature-name/
├── normal/
│   └── feature-name/
```

## Integration Customizations

### 1. CI/CD Integration

Add `.github/workflows/vibespec-check.yml`:

```yaml
name: Vibespec Compliance Check

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  check-specs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Check for specs
        run: |
          # Extract feature name from branch
          FEATURE=$(echo ${{ github.head_ref }} | sed 's/feature\///')
          
          # Check if specs exist
          if [ ! -d "specs/$FEATURE" ]; then
            echo "❌ Missing specs for feature: $FEATURE"
            exit 1
          fi
          
          # Validate spec files
          for file in requirements.md design.md tasks.md; do
            if [ ! -f "specs/$FEATURE/$file" ]; then
              echo "❌ Missing $file"
              exit 1
            fi
          done
          
          echo "✅ Specs validated"
```

### 2. IDE Integration

#### VS Code Settings

`.vscode/settings.json`:
```json
{
  "files.exclude": {
    "**/.claude": false
  },
  "workbench.colorCustomizations": {
    "activityBar.background": "#2E7D32",
    "titleBar.activeBackground": "#2E7D32"
  },
  "terminal.integrated.env.osx": {
    "VIBESPEC_MODE": "development"
  }
}
```

#### Custom Tasks

`.vscode/tasks.json`:
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Create New Feature Specs",
      "type": "shell",
      "command": "mkdir -p specs/${input:featureName} && touch specs/${input:featureName}/{requirements,design,tasks}.md",
      "problemMatcher": []
    },
    {
      "label": "Validate Specs",
      "type": "shell",
      "command": "./test-workflow.sh",
      "problemMatcher": []
    }
  ],
  "inputs": [
    {
      "id": "featureName",
      "type": "promptString",
      "description": "Feature name for specs"
    }
  ]
}
```

## Template Customization

### 1. Custom Spec Templates

Create `.vibespec/templates/`:

#### requirements-template.md
```markdown
# Requirements: {{FEATURE_NAME}}

## Business Context
[Why is this needed?]

## User Stories
- As a {{USER_TYPE}}, I want {{FEATURE}} so that {{VALUE}}

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Out of Scope
- What this feature will NOT do

## Success Metrics
- How we'll measure success
```

#### design-template.md
```markdown
# Technical Design: {{FEATURE_NAME}}

## Architecture Decision Record (ADR)
**Status**: Proposed
**Date**: {{DATE}}

## Context
[Technical background]

## Decision
[What we're building]

## Consequences
- Positive: 
- Negative:

## Alternatives Considered
1. Option A - Rejected because...
2. Option B - Rejected because...
```

### 2. Auto-Generation Script

Create `scripts/new-feature.sh`:

```bash
#!/bin/bash
# Generate specs from templates

FEATURE_NAME=$1
DATE=$(date +%Y-%m-%d)

mkdir -p specs/$FEATURE_NAME

# Copy and customize templates
for template in requirements design tasks; do
  sed -e "s/{{FEATURE_NAME}}/$FEATURE_NAME/g" \
      -e "s/{{DATE}}/$DATE/g" \
      .vibespec/templates/${template}-template.md > specs/$FEATURE_NAME/${template}.md
done

echo "✅ Created specs for: $FEATURE_NAME"
echo "📁 Location: specs/$FEATURE_NAME/"
```

## Gradual Adoption

### Phase 1: Documentation Only
Start with just documentation requirements:
```bash
# Only enforce documentation updates
rm .claude/hooks/enforce-specs.sh
rm .claude/hooks/check-workflow.sh
# Keep only update-docs.sh
```

### Phase 2: Major Features Only
Enforce specs for major features:
```bash
# Modify enforce-specs.sh
if [[ "$USER_PROMPT" =~ (major|critical|breaking) ]]; then
    # Enforce full workflow
else
    echo "ℹ️  Minor change - specs optional but recommended"
fi
```

### Phase 3: Full Adoption
Enable all enforcement mechanisms.

## Tips for Successful Customization

1. **Start Small**: Don't customize everything at once
2. **Test Changes**: Run `test-workflow.sh` after customizations
3. **Document Changes**: Update README with your customizations
4. **Team Buy-in**: Discuss changes with your team
5. **Iterate**: Adjust based on real usage

## Common Customization Scenarios

### For Startups
- Relaxed approval requirements
- Simplified documentation
- Focus on speed with quality checks

### For Enterprises
- Strict compliance checks
- Detailed audit trails
- Multiple approval gates
- Integration with existing tools

### For Open Source
- Community-friendly templates
- Contribution guidelines
- Public specs directory
- Simplified onboarding

## Getting Help with Customization

1. Review examples in this guide
2. Check `examples/` directory for patterns
3. Test customizations with `test-workflow.sh`
4. Open an issue for complex scenarios

Remember: The goal is to maintain quality while fitting your workflow!