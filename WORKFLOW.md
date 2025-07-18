# Development Workflow

## Core Principles

1. **Requirements First**: Understand before implementing
2. **Document Driven**: Specifications before code
3. **Test Everything**: Complete means tested
4. **Stay Transparent**: Track all progress

## The 6-Step Process

### Step 1: Understand & Clarify

**Goal**: Ensure complete understanding of the user's needs

- Ask clarifying questions
- Identify constraints and edge cases
- Define success criteria
- Consider non-functional requirements

**Questions to Ask**:
- What problem are we solving?
- Who are the users?
- What's the expected behavior?
- Are there performance requirements?
- What about error cases?

### Step 2: Requirements Documentation

**Goal**: Create clear, testable requirements

**File**: `specs/{feature-name}/requirements.md`

**Format**: EARS (Easy Approach to Requirements Syntax)
```
When [optional trigger], the [system name] shall [system response]
While [optional precondition], when [trigger], the [system] shall [response]
```

**Template**:
```markdown
# Requirements: [Feature Name]

## Overview
Brief description of the feature and its purpose.

## Requirements

### REQ-001: [Requirement Title]
**Priority**: High/Medium/Low
**Type**: Functional/Non-functional

When [trigger], the system shall [response].

**Acceptance Criteria**:
1. Given [context], when [action], then [outcome]
2. The response time shall be less than [X] seconds
3. Error messages shall be user-friendly

### REQ-002: [Another Requirement]
...
```

### Step 3: Technical Design

**Goal**: Document the technical approach

**File**: `specs/{feature-name}/design.md`

**Contents**:
- Architecture overview
- Technology choices and rationale
- Data models/schemas
- API contracts
- Security considerations
- Performance implications
- Testing strategy

**Template**:
```markdown
# Technical Design: [Feature Name]

## Architecture Overview
[Mermaid diagram or ASCII art]

## Technology Stack
- Language: [e.g., TypeScript]
- Framework: [e.g., Express.js]
- Database: [e.g., PostgreSQL]

## Data Model
```json
{
  "user": {
    "id": "uuid",
    "email": "string",
    "role": "enum"
  }
}
```

## API Design
### POST /api/auth/login
Request:
```json
{
  "email": "string",
  "password": "string"
}
```

Response:
```json
{
  "token": "jwt",
  "user": {}
}
```

## Security Considerations
- Input validation
- Rate limiting
- JWT expiration

## Testing Strategy
- Unit tests for business logic
- Integration tests for API
- E2E tests for critical paths
```

### Step 4: Task Breakdown

**Goal**: Create actionable implementation tasks

**File**: `specs/{feature-name}/tasks.md`

**Format**:
```markdown
# Implementation Tasks: [Feature Name]

## Overview
Total estimated time: [X hours/days]
Dependencies: [List any blockers]

## Tasks

- [ ] 1. Set up project structure
  - Create necessary directories
  - Install dependencies
  - Configure build tools
  - **Time**: 1h
  - **Requirement**: General setup

- [ ] 2. Implement data model
  - Create database schema
  - Write migration scripts
  - Add validation rules
  - **Time**: 2h
  - **Requirement**: REQ-001

- [ ] 3. Create API endpoints
  - Implement POST /api/auth/login
  - Add input validation
  - Handle error cases
  - **Time**: 3h
  - **Requirement**: REQ-002

- [ ] 4. Write tests
  - Unit tests for auth logic
  - API integration tests
  - **Time**: 2h
  - **Requirement**: All

- [ ] 5. Update documentation
  - API documentation
  - README updates
  - **Time**: 1h
  - **Requirement**: General
```

### Step 5: Implementation

**Goal**: Execute the plan

**Process**:
1. Follow the task list sequentially
2. Update task checkboxes as you progress
3. Reference requirements when making decisions
4. Run tests continuously
5. Commit with meaningful messages

**Best Practices**:
- One task, one commit (when possible)
- Reference task numbers in commits
- Keep code aligned with design
- Don't skip tests

### Step 6: Summary & Documentation

**Goal**: Document outcomes and learnings

**File**: `specs/{feature-name}/summary.md` (Optional)

**Contents**:
- What was delivered
- Key decisions and trade-offs
- Challenges and solutions
- Performance metrics
- Future improvements
- Lessons learned

## Quick Reference

### For New Features
1. User request → Understand & clarify
2. Create `requirements.md` → Get approval
3. Create `design.md` → Get approval
4. Create `tasks.md` → Get approval
5. Implement following tasks
6. Update docs and create summary

### For Bug Fixes
1. Understand the issue
2. Create minimal spec in `specs/bugfix-{name}/`
3. Document root cause in `requirements.md`
4. Outline fix approach in `design.md`
5. Fix and test
6. Update relevant docs

### For Refactoring
1. Document current state and issues
2. Create `specs/refactor-{name}/requirements.md`
3. Design new approach in `design.md`
4. Plan migration in `tasks.md`
5. Implement incrementally
6. Ensure tests still pass

## Tips for Success

- **Don't Rush**: Time spent in specs saves time in implementation
- **Be Specific**: Vague requirements lead to rework
- **Think Edge Cases**: Consider error scenarios upfront
- **Stay Organized**: One feature = one spec directory
- **Iterate**: Specs can be updated as you learn

Remember: The goal is not bureaucracy, but clarity and quality. Adapt the process to your needs while maintaining the core principle of thinking before coding.