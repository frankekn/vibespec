# Security Policy

## Supported Versions

Currently supporting security updates for:

| Version | Supported          |
| ------- | ------------------ |
| 2.0.x   | :white_check_mark: |
| < 2.0   | :x:                |

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability, please follow these steps:

### 1. Do NOT Create a Public Issue

Security vulnerabilities should not be reported via GitHub issues as they are publicly visible.

### 2. Report Privately

Send details to the project maintainers through one of these channels:
- GitHub Security Advisory (preferred)
- Direct message to maintainers

### 3. Include Details

Your report should include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

### 4. Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Resolution Target**: Within 30 days for critical issues

## Security Considerations for Vibespec

### Hook Scripts

The hook scripts run with user permissions and execute shell commands. Be aware:

1. **Command Injection**: Hooks process user input and file paths
   - Sanitize all inputs
   - Use proper quoting
   - Avoid eval statements

2. **File System Access**: Hooks read and check files
   - Validate all file paths
   - Prevent directory traversal
   - Check permissions

3. **Git Commands**: Hooks execute git commands
   - Validate git repository state
   - Handle untrusted input carefully

### Best Practices

When using or modifying Vibespec:

1. **Review Hook Scripts**: Understand what the scripts do
2. **Limit Permissions**: Run with minimal required permissions
3. **Validate Input**: Never trust user input
4. **Update Regularly**: Keep Vibespec updated

### Known Limitations

- Hooks require bash (security implications on Windows)
- No sandboxing of hook execution
- Relies on Claude Code's security model

## Responsible Disclosure

We support responsible disclosure:

1. Report vulnerabilities privately first
2. Allow reasonable time for fixes
3. Coordinate on disclosure timing
4. Credit researchers appropriately

## Security Updates

Security updates will be:
- Released as patch versions
- Announced in release notes
- Documented in CHANGELOG.md

Thank you for helping keep Vibespec secure!