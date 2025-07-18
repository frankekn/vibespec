# Contributing to Vibespec

Thank you for your interest in contributing to Vibespec! This project follows its own workflow, so contributions must follow the specs-first approach.

## 🎯 Quick Start

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/vibespec.git`
3. Install Vibespec in the project: `./install.sh .`
4. Create a feature branch: `git checkout -b feature/your-feature-name`
5. Follow the Vibespec workflow for your contribution

## 📋 Contribution Workflow

All contributions must follow the Vibespec workflow:

### 1. Create Specifications

Before any code changes, create specs for your contribution:

```bash
mkdir -p specs/your-feature
```

Create three files:

#### specs/your-feature/requirements.md
- Describe WHAT you're adding/changing
- Use EARS format for requirements
- Include acceptance criteria

#### specs/your-feature/design.md
- Explain HOW you'll implement it
- Include technical decisions
- Note any breaking changes

#### specs/your-feature/tasks.md
- Break down implementation steps
- Include time estimates
- Link tasks to requirements

### 2. Get Approval

1. Create a draft PR with just the specs
2. Label it with `specs-review`
3. Wait for maintainer feedback
4. Update specs based on feedback

### 3. Implement

After specs are approved:
1. Implement following your tasks.md
2. Update task checkboxes as you progress
3. Run tests: `./test-workflow.sh`
4. Update documentation if needed

## 🚀 Types of Contributions

### Bug Fixes
- Create minimal specs in `specs/bugfix-issue-number/`
- Include bug description and fix approach
- Link to the issue number

### New Features
- Full specs required
- Consider backward compatibility
- Update examples if applicable

### Documentation
- Specs optional for minor updates
- Required for new guides or major changes
- Ensure consistency with existing docs

### Hook Improvements
- Test thoroughly with `test-workflow.sh`
- Consider cross-platform compatibility
- Document any new patterns

## 🧪 Testing

Before submitting:

```bash
# Run the test suite
./test-workflow.sh

# Test installation in a clean directory
mkdir test-install && cd test-install
../install.sh .
# Verify hooks work
cd .. && rm -rf test-install
```

## 📝 Pull Request Process

1. **Title**: Use conventional commit format
   - `feat: add custom workflow templates`
   - `fix: correct hook pattern matching`
   - `docs: improve customization guide`

2. **Description**: Include
   - Link to specs (in the PR)
   - Summary of changes
   - Testing performed
   - Breaking changes (if any)

3. **Checklist**:
   - [ ] Specs created and approved
   - [ ] All tests pass
   - [ ] Documentation updated
   - [ ] No breaking changes (or documented)
   - [ ] Works on macOS/Linux

## 🎨 Code Style

### Bash Scripts
- Use shellcheck for linting
- Add error handling
- Include helpful error messages
- Comment complex logic

### Markdown
- Use proper headings hierarchy
- Include code examples
- Keep line length reasonable
- Use emoji sparingly and consistently

## 🐛 Reporting Issues

### Before Creating an Issue
1. Check existing issues
2. Try latest version
3. Run `test-workflow.sh`
4. Verify installation is correct

### Issue Template
```markdown
**Environment:**
- OS: [e.g., macOS 14.0]
- Shell: [e.g., bash 5.2]
- Claude Code version: [if known]

**Description:**
Clear description of the issue

**Steps to Reproduce:**
1. Step one
2. Step two
3. ...

**Expected Behavior:**
What should happen

**Actual Behavior:**
What actually happens

**Logs/Output:**
```
Any relevant output
```
```

## 🤝 Code of Conduct

### Be Respectful
- Welcome newcomers
- Be patient with questions
- Respect different opinions

### Be Collaborative
- Work together on solutions
- Share knowledge
- Help others learn

### Be Professional
- Stay on topic
- No harassment or discrimination
- Focus on what's best for the project

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## ❓ Questions?

- Check the [documentation](docs/)
- Open a discussion (not an issue) for questions
- Review existing PRs for examples

## 🙏 Recognition

Contributors will be:
- Listed in the README
- Credited in release notes
- Thanked in commit messages

Thank you for helping make Vibespec better! 🚀