# Getting Started with Vibespec

Welcome to Vibespec! This guide will help you set up a specs-first development workflow in your project.

## What is Vibespec?

Vibespec is a development workflow system for Claude Code that enforces planning before implementation. It ensures:

- Clear requirements before coding
- Technical designs are documented
- Tasks are planned and tracked
- Documentation stays current

## Installation

### Prerequisites

- A project using Claude Code
- Git (recommended)
- Bash shell (for installation script)

### Platform Requirements

- **macOS**: No additional requirements
- **Linux**: No additional requirements  
- **Windows**: Requires one of:
  - Windows Subsystem for Linux (WSL) - Recommended
  - Git Bash - Comes with Git for Windows
  - Cygwin - Alternative option

⚠️ **Windows Note**: Native PowerShell/CMD is not supported. The hooks use bash scripts that require a Unix-like environment.

### Quick Install

1. Clone the Vibespec repository:
```bash
git clone https://github.com/frankekn/vibespec.git
cd vibespec
```

2. Run the installer on your project:
```bash
./install.sh /path/to/your/project
```

3. The installer will:
   - Append workflow rules to your CLAUDE.md (or create one)
   - Add WORKFLOW.md with the complete process
   - Set up hooks in `.claude/`
   - Create a `specs/` directory

### Manual Installation

If you prefer to install manually:

```bash
# Copy core files
cp vibespec/WORKFLOW.md your-project/
cp vibespec/workflow-rules.md your-project/

# Append rules to your CLAUDE.md
cat vibespec/workflow-rules.md >> your-project/CLAUDE.md

# Copy hooks
cp -r vibespec/.claude your-project/
```

## Your First Feature with Vibespec

Let's walk through adding a feature using the workflow:

### 1. Start a Conversation

Open your project in Claude Code and say:
```
I want to add a user registration feature
```

### 2. Claude Will Clarify Requirements

Claude will respond with questions like:
```
I'll help you add user registration. Following the Vibespec workflow, 
let me first understand your requirements:

1. What information should we collect?
   - Email, username, password?
   - Additional profile fields?

2. Any validation requirements?
   - Password complexity?
   - Email verification?

3. What happens after registration?
   - Auto-login?
   - Confirmation email?
```

### 3. Requirements Documentation

After you answer, Claude creates `specs/user-registration/requirements.md`:

```markdown
# Requirements: User Registration

## Overview
Allow new users to create accounts in the system.

## Requirements

### REQ-001: User Registration Form
When a user submits valid registration data, the system shall create a new account and return success within 3 seconds.

**Acceptance Criteria**:
1. Email must be unique
2. Password must be at least 8 characters
3. Success returns user ID and auth token
```

### 4. Technical Design

After you approve requirements, Claude creates `design.md`:

```markdown
# Technical Design: User Registration

## API Endpoint
POST /api/auth/register

## Data Model
{
  "email": "string",
  "password": "string",
  "username": "string"
}

## Security
- Bcrypt for password hashing
- Rate limiting: 5 attempts per hour
- Input validation on all fields
```

### 5. Task Planning

Then Claude creates `tasks.md`:

```markdown
# Implementation Tasks

- [ ] 1. Create user model and migration
  - Add users table
  - Include email, password_hash, username
  - Time: 1h
  - _Requirement: REQ-001_

- [ ] 2. Implement registration endpoint
  - Input validation
  - Password hashing
  - Error handling
  - Time: 2h
  - _Requirement: REQ-001_

- [ ] 3. Add tests
  - Unit tests for validation
  - Integration tests for endpoint
  - Time: 1h
  - _Requirement: REQ-001_
```

### 6. Implementation

Only after you approve all specs, Claude begins coding, updating task checkboxes as it progresses.

## Understanding the Workflow

The workflow has 6 steps:

1. **Understand** - Clarify what's needed
2. **Requirements** - Document WHAT to build
3. **Design** - Document HOW to build
4. **Tasks** - Plan the work
5. **Code** - Implement the plan
6. **Update** - Keep docs current

## Hooks System

Vibespec includes hooks that:

- **Remind about workflow** when you try to skip steps
- **Suggest documentation updates** after code changes
- **Enforce specs-first** development

## Customization

### Adjusting Hook Sensitivity

Edit `.claude/settings.json` to change when hooks trigger:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "matcher": "your-custom-pattern",
        "hooks": [...]
      }
    ]
  }
}
```

### Workflow for Different Project Types

- **Small features**: Can use simplified specs
- **Bug fixes**: Minimal requirements focusing on the issue
- **Refactoring**: Design doc explaining the changes

## Troubleshooting

### "Vibespec rules already exist"

The installer detected Vibespec is already installed. To reinstall:
1. Remove the Vibespec section from CLAUDE.md
2. Run the installer again

### Hooks not triggering

Ensure:
- `.claude/hooks/*.sh` files are executable
- `.claude/settings.json` exists
- Claude Code can access the files

### Want to skip workflow temporarily?

While not recommended, you can tell Claude:
```
For this debugging session only, skip the formal workflow
```

## Best Practices

1. **Don't fight the workflow** - It's there to help
2. **Keep specs updated** - Update them as requirements change
3. **Use examples** - Include examples in requirements
4. **Think edge cases** - Document error scenarios

## Next Steps

- Read [WORKFLOW.md](../WORKFLOW.md) for detailed process info
- Check [examples/](../examples/) for real-world usage
- See [CUSTOMIZATION.md](CUSTOMIZATION.md) for advanced setup

Happy spec-driven development! 🚀