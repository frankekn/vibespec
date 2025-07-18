# Simple API Example - Vibespec Workflow

This example demonstrates how to use Vibespec workflow for building an API with user authentication.

## Project Structure

```
simple-api/
├── specs/
│   └── user-auth/
│       ├── requirements.md    # What to build (EARS format)
│       ├── design.md          # How to build it
│       └── tasks.md           # Step-by-step plan
├── src/
│   └── (implementation goes here after specs approval)
└── README.md
```

## The Workflow in Action

### 1. Requirements First

Look at `specs/user-auth/requirements.md` to see:
- Clear requirements in EARS format
- Acceptance criteria for each requirement
- Priority levels

Key example:
```
When a new user submits valid registration information, 
the system shall create a user account and return a 
success response within 3 seconds.
```

### 2. Technical Design

Check `specs/user-auth/design.md` for:
- Architecture diagrams
- Technology choices
- API contracts
- Security considerations

### 3. Task Planning

See `specs/user-auth/tasks.md` for:
- Broken down implementation tasks
- Time estimates
- Dependencies between tasks
- Links back to requirements

## How to Use This Example

1. **Study the specs** - Notice how each document builds on the previous
2. **Follow the pattern** - Use these as templates for your own features
3. **Maintain the discipline** - Always specs before code

## Conversation Example

Here's how a conversation might go:

```
You: "I need to add password reset functionality"

Claude: "I'll help you add password reset. Following the Vibespec workflow, 
let me first understand your requirements:

1. How should users initiate password reset?
   - Email link?
   - Security questions?
   
2. What's the token expiration time?

3. Should we notify users of password changes?

After clarifying, I'll create specs/password-reset/requirements.md"
```

## Key Takeaways

1. **No coding without specs** - Even if you're eager to start
2. **Specs evolve** - Update them as you learn
3. **Small features still need specs** - Even a "simple" button
4. **Documentation included** - It's part of the task list

This example shows the workflow for a medium-complexity feature. The same process scales up for large features and down for small ones.