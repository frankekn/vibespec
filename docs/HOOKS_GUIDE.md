# Hooks Guide

This guide explains how Vibespec's hook system enforces the specs-first workflow and ensures documentation stays current.

## Overview

Vibespec uses Claude Code's hook system to enforce workflow compliance. The hooks run automatically when you interact with Claude Code, blocking actions that violate the workflow and reminding you to update documentation.

## Core Principles

1. **Enforce specs-first development** - Can't code without approved specs
2. **Remind about documentation updates** - Suggests doc updates after code changes
3. **Allow emergency bypasses** - Flexibility for critical situations
4. **Non-intrusive reminders** - Helpful without being annoying

## Hook Types

### 1. Workflow Enforcement Hooks

#### `enforce-specs.sh`
**Purpose**: Blocks feature development without specs

**Triggers on**: User prompts containing:
- "add feature"
- "implement functionality"
- "create component"
- "build system"

**Actions**:
- Blocks the request if no specs exist
- Provides clear workflow sequence
- Shows emergency bypass option

**Example**:
```bash
User: "Add user authentication"
Hook: 🛑 VIBESPEC WORKFLOW ENFORCEMENT
      ❌ Cannot proceed without following specs-first workflow!
```

#### `check-workflow.sh`
**Purpose**: Prevents coding without complete specifications

**Triggers on**: Editing code files (js, py, java, etc.)

**Actions**:
- Checks if specs directory exists
- Validates all three spec files are present
- Blocks if specs are incomplete
- Skips checking for test files and spec files

**Example**:
```bash
Editing: src/auth.js
Hook: 🛑 INCOMPLETE SPECS: auth
      ❌ Missing design.md for feature 'auth'
      📋 Complete specs/auth/design.md first
```

#### `approval-gate.sh`
**Purpose**: Enforces approval between workflow steps

**Triggers on**: Creating design.md, tasks.md, or starting implementation

**Actions**:
- Checks if previous step was approved
- Blocks progression without approval
- Reminds to wait for user confirmation

### 2. Documentation Update Hook

#### `update-docs.sh`
**Purpose**: Reminds to update documentation after code changes

**Triggers on**: After editing source code files

**Actions**:
- Reminds to update task checkboxes
- Suggests documenting design decisions
- Prompts for README updates if needed
- Non-blocking (just suggestions)

**Example**:
```bash
Modified: src/api/users.js
Hook: 📝 Vibespec Documentation Update Reminder
      ✓ Update corresponding tasks.md checkboxes
      ✓ Consider updating README.md if this adds new features
```

## Hook Configuration

The hooks are configured in `.claude/settings.json`:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "matcher": ".*(?:add|implement|create|build|develop|make).*(?:feature|functionality|component|system|api|endpoint).*",
        "hooks": [
          {
            "type": "command",
            "command": "./.claude/hooks/enforce-specs.sh"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": {
          "tools": ["Edit", "Write", "MultiEdit"],
          "paths": "!specs/**"
        },
        "hooks": [
          {
            "type": "command",
            "command": "./.claude/hooks/check-workflow.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": {
          "tools": ["Edit", "Write", "MultiEdit"],
          "paths": "**/*.{js,jsx,ts,tsx,py,go,java,rs,rb,php,swift,kt,scala,c,cpp,h,hpp,cs}"
        },
        "hooks": [
          {
            "type": "command",
            "command": "./.claude/hooks/update-docs.sh"
          }
        ]
      }
    ]
  }
}
```

## Emergency Bypass

For critical situations, you can bypass the workflow:

### Bypass Keywords:
- "emergency bypass"
- "debug mode"
- "skip workflow"
- "hotfix"

### Example:
```bash
User: "Emergency bypass for critical production bug"
Hook: ⚠️  Vibespec workflow bypassed for emergency/debug mode
```

## Hook Behavior

### What Gets Blocked:
- Starting new features without specs
- Writing code without complete specifications
- Progressing through workflow without approvals
- Creating design.md before requirements.md is approved

### What's Allowed:
- Editing test files
- Updating documentation
- Modifying spec files
- Emergency bypasses
- Reading and exploring code

### Exit Codes:
- `0` (Success) - Action is allowed
- `1` (Failure) - Action is blocked

## Customizing Hooks

### Adjusting Sensitivity

To make hooks less strict, edit the matcher patterns in `.claude/settings.json`:

```json
{
  "matcher": ".*(?:major|significant).*(?:feature|change).*"
}
```

### Disabling Hooks

To temporarily disable hooks:

1. Rename `.claude/settings.json` to `.claude/settings.json.disabled`
2. Or remove specific hook entries from the configuration

### Adding Custom Patterns

Edit the hook scripts to add your own patterns:

```bash
# In enforce-specs.sh
if [[ "$USER_PROMPT" =~ (your-pattern-here) ]]; then
    # Your custom logic
fi
```

## Troubleshooting

### Hooks Not Triggering

1. **Check file permissions**:
   ```bash
   chmod +x .claude/hooks/*.sh
   ```

2. **Verify settings.json exists**:
   ```bash
   ls -la .claude/settings.json
   ```

3. **Test hooks manually**:
   ```bash
   export USER_PROMPT="add new feature"
   ./.claude/hooks/enforce-specs.sh
   ```

### Hooks Too Restrictive

1. Use bypass keywords for one-time exceptions
2. Edit patterns to be more specific
3. Temporarily disable hooks for debugging

### Performance Issues

Hooks run synchronously and may add slight delays. If experiencing issues:

1. Simplify pattern matching
2. Remove unnecessary checks
3. Use early exits in scripts

## Best Practices

1. **Don't fight the workflow** - It's there to help maintain quality
2. **Use bypasses sparingly** - Only for true emergencies
3. **Keep hooks updated** - Adjust patterns as your project evolves
4. **Test changes** - Run `test-workflow.sh` after modifying hooks
5. **Document customizations** - Note any changes for team members

## Platform Notes

Currently, hooks require Bash and are tested on:
- ✅ macOS
- ✅ Linux
- ❌ Windows (requires WSL or Git Bash)

For Windows users, consider using Windows Subsystem for Linux (WSL) or Git Bash.

## Getting Help

If hooks are causing issues:

1. Check this guide first
2. Run `test-workflow.sh` to validate setup
3. Review hook scripts for errors
4. Open an issue on GitHub with details

Remember: The hooks are designed to improve code quality by enforcing planning before implementation. They should guide, not frustrate!