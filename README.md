<div align="center">

<pre>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

     ██╗   ██╗██╗██████╗ ███████╗███████╗██████╗ ███████╗ ██████╗
     ██║   ██║██║██╔══██╗██╔════╝██╔════╝██╔══██╗██╔════╝██╔════╝
     ██║   ██║██║██████╔╝█████╗  ███████╗██████╔╝█████╗  ██║     
     ╚██╗ ██╔╝██║██╔══██╗██╔══╝  ╚════██║██╔═══╝ ██╔══╝  ██║     
      ╚████╔╝ ██║██████╔╝███████╗███████║██║     ███████╗╚██████╗
       ╚═══╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚═╝     ╚══════╝ ╚═════╝

           S P E C S - F I R S T   D E V E L O P M E N T
                     F O R   C L A U D E   C O D E

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
</pre>

<br>

[![License: MIT](https://img.shields.io/badge/License-MIT-2e86de.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/Version-2.0.0-10b981.svg)](https://github.com/frankekn/vibespec)
[![Inspired by](https://img.shields.io/badge/Inspired%20by-Amazon%20Kiro%20IDE-e67e22.svg)](https://github.com/frankekn/vibespec)

<br>

**Transform your development process with enforced planning before implementation**

<br>

[**Getting Started**](docs/GETTING_STARTED.md) · 
[**Documentation**](docs/) · 
[**Examples**](examples/) · 
[**Contributing**](CONTRIBUTING.md)

<br>

</div>

## Quick Start

### Installation Options

**Option 1: One-Command Install (Recommended)**
```bash
curl -sSL https://raw.githubusercontent.com/frankekn/vibespec/main/remote-install.sh | bash
```

**Option 2: Git Clone Install**
```bash
git clone https://github.com/frankekn/vibespec.git
cd vibespec
./install.sh /path/to/your/project
```

**Option 3: Manual Install**
```bash
cp vibespec/{WORKFLOW.md,workflow-rules.md} your-project/
cp -r vibespec/.claude your-project/
```

## 📋 What It Does

- **Enforces** specs-first development workflow for Claude Code
- **Appends** workflow rules to your existing CLAUDE.md (non-destructive)
- **Adds** WORKFLOW.md with the complete 6-step process
- **Installs** hooks that **BLOCK** coding without approved specs
- **Creates** specs/ directory for your requirements and designs
- **Ensures** Claude cannot skip workflow steps

## 🔄 The Workflow

1. **Understand** - Clarify requirements with the user
2. **Requirements** - Document in EARS format (`specs/{feature}/requirements.md`)
3. **Design** - Technical approach (`specs/{feature}/design.md`)
4. **Tasks** - Implementation plan (`specs/{feature}/tasks.md`)
5. **Code** - Implementation following the specs
6. **Update** - Keep documentation current

## 🎯 How It Works

After installation, Claude **MUST** follow this enforced pattern:

```
You: "Add user authentication"

Claude: "I'll help you add user authentication. Following the Vibespec workflow, 
let me first understand your requirements:
- What type of authentication? (JWT, OAuth, etc.)
- What are the user roles?
- Any specific security requirements?

After clarifying, I'll create specs/user-authentication/requirements.md

⏳ I will then WAIT for your approval before proceeding to design.md"
```

**Key Enforcement Points:**
- Claude **CANNOT** skip to coding without creating specs
- Claude **MUST** wait for approval between each step
- Hooks **BLOCK** actions that violate the workflow
- All 3 spec files (requirements/design/tasks) are **REQUIRED** before coding

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
- "I want to add a search feature" → **ENFORCED:** Creates specs first
- "Just quickly add a button" → **ENFORCED:** Still creates minimal specs
- "Implement the login from specs" → **ENFORCED:** Only works with approved specs
- "Emergency bypass for critical bug" → **ALLOWED:** Bypasses workflow

**What happens if you try to skip workflow:**
```bash
You: "Just add some code to fix this"
Claude: 🛑 VIBESPEC WORKFLOW ENFORCEMENT
❌ Cannot proceed without following specs-first workflow!
```

## 📚 Documentation

- [Getting Started](docs/GETTING_STARTED.md) - Detailed setup guide
- [WORKFLOW.md](WORKFLOW.md) - Complete workflow documentation
- [Hooks Guide](docs/HOOKS_GUIDE.md) - Understanding the enforcement system
- [Customization](docs/CUSTOMIZATION.md) - Adapting to your needs

## 🖥️ Platform Support

- ✅ **macOS**: Fully supported
- ✅ **Linux**: Fully supported  
- ⚠️ **Windows**: Requires WSL or Git Bash (bash scripts only)

## 🔧 Installation Time

- **One-command install**: < 30 seconds
- **First feature spec**: < 5 minutes
- **Learning curve**: Works immediately, no manual required
- **Enforcement**: Automatic, no configuration needed

## 🤝 Contributing

We welcome contributions! Please follow the Vibespec workflow when adding features to Vibespec itself.

## 📄 License

MIT License - see [LICENSE](LICENSE) file

## 👤 Author

**Frank Yang**  
Email: vibespecs@gmail.com

---

Made with ❤️ for the Claude Code community  
Inspired by Amazon's Kiro IDE