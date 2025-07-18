## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## 🚨 VIBESPEC WORKFLOW RULES - START
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### MANDATORY: Specs-First Development

You MUST follow this EXACT workflow for ALL new features and significant changes. NO EXCEPTIONS.

**STRICT SEQUENCE - NEVER SKIP OR COMBINE STEPS:**

1. **Understand & Clarify**: When user requests a feature, ask clarifying questions FIRST
2. **Create Requirements**: Write `specs/{feature}/requirements.md` using EARS format
3. **⏳ WAIT FOR APPROVAL**: Say "Please review requirements.md before I continue to design"
4. **Design Solution**: Write `specs/{feature}/design.md` with technical approach
5. **⏳ WAIT FOR APPROVAL**: Say "Please review design.md before I continue to tasks"
6. **Plan Tasks**: Write `specs/{feature}/tasks.md` with implementation steps
7. **⏳ WAIT FOR APPROVAL**: Say "Please review tasks.md before I start coding"
8. **Implement**: Only start coding after ALL specs are approved
9. **Update Docs**: Keep documentation current with changes

**CRITICAL ENFORCEMENT RULES:**
- You CANNOT proceed to the next step without explicit user approval
- You MUST create the specs directory structure before any coding
- You MUST wait for user confirmation between each step
- You CANNOT implement features not documented in approved specs

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

❌ **NEVER** (THESE WILL BLOCK YOUR ACTIONS):
- Skip directly to coding without specs
- Implement features not documented in specs
- Merge workflow steps without user approval
- Assume requirements without clarification
- Create design.md before requirements.md is approved
- Create tasks.md before design.md is approved
- Start coding before tasks.md is approved
- Combine multiple workflow steps in one response

✅ **ALWAYS** (MANDATORY REQUIREMENTS):
- Create specs directory structure first
- Wait for user confirmation between each step
- Say "Please review [filename] before I continue" after each spec
- Update task checkboxes during implementation
- Reference spec files when coding
- Ask clarifying questions before writing requirements
- Stop and wait for approval before proceeding to next step

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

After you clarify these points, I'll create `specs/user-authentication/requirements.md` using the EARS format.

⏳ I will then WAIT for your approval before proceeding to design.md."
```

**For Quick Requests:**
```
User: "Just add a delete button"

You: "I understand you need a delete button. Even for small changes, I'll follow the Vibespec workflow to ensure quality. Let me quickly understand:

1. What should this button delete?
2. Where should it be placed?
3. Should there be a confirmation dialog?
4. Who can see/use this button?

I'll then create a minimal spec in `specs/delete-button/requirements.md`.

⏳ I will WAIT for your approval before creating design.md.
⏳ I will WAIT for your approval before creating tasks.md.
⏳ I will WAIT for your approval before starting implementation."
```

**BYPASS MECHANISMS (RARE CASES ONLY):**
```
User: "Emergency bypass for critical production bug"
User: "Debug mode this session only"
User: "Skip workflow for this hotfix"

You: "Understood. Bypassing Vibespec workflow for this emergency situation."
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