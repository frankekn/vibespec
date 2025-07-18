## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## 🚨 VIBESPEC WORKFLOW RULES - START
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### MANDATORY: Specs-First Development

You MUST follow this workflow for ALL new features and significant changes:

1. **Understand & Clarify**: When user requests a feature, first understand the requirements thoroughly
2. **Create Requirements**: Write `specs/{feature}/requirements.md` using EARS format
3. **Design Solution**: Write `specs/{feature}/design.md` with technical approach
4. **Plan Tasks**: Write `specs/{feature}/tasks.md` with implementation steps
5. **Implement**: Only start coding after specs are approved
6. **Update Docs**: Keep documentation current with changes

### EARS Format for Requirements

When writing requirements, use:
- **When** [trigger condition], **the** [system name] **shall** [system response]
- **While** [precondition], **when** [trigger], **the** [system] **shall** [response]
- Include clear, testable acceptance criteria
- Each requirement must be verifiable

Example:
```
When user clicks "Login", the system shall validate credentials and return JWT token within 2 seconds.
```

### Workflow Enforcement

❌ **NEVER**:
- Skip directly to coding without specs
- Implement features not documented in specs
- Merge workflow steps without user approval
- Assume requirements without clarification

✅ **ALWAYS**:
- Create specs directory structure first
- Wait for user confirmation between each step
- Update task checkboxes during implementation
- Reference spec files when coding
- Ask clarifying questions before writing requirements

### Example Response Patterns

**For New Features:**
```
User: "Add user authentication"

You: "I'll help you add user authentication. Following the Vibespec workflow, let me first understand your requirements:

1. What type of authentication do you need?
   - JWT tokens
   - OAuth (Google, GitHub, etc.)
   - Simple username/password
   - Other?

2. What user information should we store?
   - Email, username, profile?
   - Roles or permissions?

3. Any specific security requirements?
   - Password complexity rules?
   - Session timeout?
   - Multi-factor authentication?

After you clarify these points, I'll create `specs/user-authentication/requirements.md` using the EARS format."
```

**For Quick Requests:**
```
User: "Just add a delete button"

You: "I understand you need a delete button. Even for small changes, I'll follow the Vibespec workflow to ensure quality. Let me quickly understand:

1. What should this button delete?
2. Where should it be placed?
3. Should there be a confirmation dialog?
4. Who can see/use this button?

I'll then create a minimal spec in `specs/delete-button/requirements.md`."
```

### Documentation Updates

After code changes, check if these need updates:
- **README.md** - New features or setup changes
- **API docs** - New or modified endpoints
- **Configuration** - New settings or options
- **Examples** - Usage examples for new features

### Task Management

When creating tasks.md:
```markdown
# Implementation Tasks

- [ ] 1. Task description
  - Specific technical details
  - Acceptance criteria
  - Estimated time: 2h
  - _Requirement: REQ-001_

- [ ] 2. Another task
  - Implementation notes
  - Dependencies: Task 1
  - _Requirement: REQ-002_
```

Update checkboxes as you progress:
- `[ ]` - Not started
- `[x]` - Completed

### Summary Documents

After implementation, optionally create `specs/{feature}/summary.md`:
- Key decisions made
- Challenges encountered
- Performance considerations
- Future improvements

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## 🚨 VIBESPEC WORKFLOW RULES - END
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━