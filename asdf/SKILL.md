---
name: asdf
description: >
  Manage multiple runtime versions (Python, Node.js, Go, etc.) with a single tool.
  Install, switch, and manage language versions per project using .tool-versions files.
  Use when you need to install or switch runtime versions for development.
compatibility: Requires bash/zsh shell, git
license: MIT
metadata:
  author: asdf-vm
  version: "0.14.0"
  homepage: https://asdf-vm.com
---

# asdf Version Manager

## When to use this skill

Manage runtime versions for projects. Install Python, Node.js, Go, or other language runtimes. Switch versions per project using `.tool-versions` files.

## Quick start

### Install a runtime

```bash
# Add plugin
asdf plugin add python

# Install version
asdf install python 3.12.0

# Set global default
asdf global python 3.12.0

# Set project version
asdf local python 3.12.0
```

### Common runtimes

```bash
# Python
asdf plugin add python && asdf install python 3.12.0

# Node.js
asdf plugin add nodejs && asdf install nodejs 20.10.0

# Go
asdf plugin add golang && asdf install golang 1.21.5
```

### Install from .tool-versions

```bash
# asdf automatically reads .tool-versions in current directory
asdf install
```

## Common commands

```bash
# Plugin management
asdf plugin list                    # List installed plugins
asdf plugin add <name>              # Add plugin
asdf plugin update --all            # Update all plugins

# Version management
asdf list <plugin>                  # List installed versions
asdf list all <plugin>              # List all available versions
asdf install <plugin> <version>     # Install version
asdf uninstall <plugin> <version>   # Uninstall version

# Set versions
asdf global <plugin> <version>      # Set global default
asdf local <plugin> <version>       # Set project version (.tool-versions)
asdf current                        # Show current versions

# Utility
asdf reshim <plugin>                # Rebuild shims
asdf which <command>                # Show path to command
```

## Configuration

asdf uses `~/.tool-versions` for global defaults and `.tool-versions` in project directories for project-specific versions.

Example `.tool-versions`:
```
python 3.12.0
nodejs 20.10.0
```

## Common issues

- **Command not found**: Run `asdf reshim <plugin>` to rebuild shims
- **Version not available**: Update plugin with `asdf plugin update <plugin>`
- **Slow installs**: Some plugins compile from source (Python)
- **Shell not configured**: Ensure asdf is sourced in shell rc file
