# Vibespec

A specs-first development workflow for Claude Code that ensures quality through structured planning before implementation.

## 🚀 Quick Start

### Installation

Clone and install:
```bash
git clone https://github.com/frankekn/vibespec.git
cd vibespec
./install.sh /path/to/your/project
```

Or manually copy files:
```bash
cp vibespec/{WORKFLOW.md,workflow-rules.md} your-project/
cp -r vibespec/.claude your-project/
```

## 📋 What It Does

- **Appends** workflow rules to your existing CLAUDE.md (non-destructive)
- **Adds** WORKFLOW.md with the complete 6-step process
- **Installs** hooks that enforce specs-first development
- **Creates** specs/ directory for your requirements and designs

## 🔄 The Workflow

1. **Understand** - Clarify requirements with the user
2. **Requirements** - Document in EARS format (`specs/{feature}/requirements.md`)
3. **Design** - Technical approach (`specs/{feature}/design.md`)
4. **Tasks** - Implementation plan (`specs/{feature}/tasks.md`)
5. **Code** - Implementation following the specs
6. **Update** - Keep documentation current

## 🎯 How It Works

After installation, Claude will follow this pattern:

```
You: "Add user authentication"

Claude: "I'll help you add user authentication. Following the Vibespec workflow, 
let me first understand your requirements:
- What type of authentication? (JWT, OAuth, etc.)
- What are the user roles?
- Any specific security requirements?

After clarifying, I'll create specs/user-authentication/requirements.md"
```

## 🔧 For Existing Projects

If you already have a CLAUDE.md file, Vibespec will:
- Append workflow rules with clear section markers
- Preserve all your existing instructions
- Add rules that work alongside your current setup

## 📁 What's Included

```
your-project/
├── CLAUDE.md         # Your existing + Vibespec rules
├── WORKFLOW.md       # Detailed process documentation
├── specs/            # Feature specifications
└── .claude/          # Hooks configuration
    ├── settings.json # Hook definitions
    └── hooks/        # Enforcement scripts
```

## 🧪 Test It Out

After installation, try these commands:
- "I want to add a search feature" → Creates specs first
- "Just quickly add a button" → Still creates minimal specs
- "Implement the login from specs" → Follows the plan

## 📚 Documentation

- [Getting Started](docs/GETTING_STARTED.md) - Detailed setup guide
- [Hooks Guide](docs/HOOKS_GUIDE.md) - Understanding the hook system
- [Customization](docs/CUSTOMIZATION.md) - Adapting to your needs

## 🤝 Contributing

We welcome contributions! Please follow the Vibespec workflow when adding features to Vibespec itself.

## 📄 License

MIT License - see [LICENSE](LICENSE) file

---

Made with ❤️ for the Claude Code community