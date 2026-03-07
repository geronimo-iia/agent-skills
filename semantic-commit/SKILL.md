---
name: semantic-commit
description: >-
  Create semantic commits following sp_theory standards with interactive prompts.
  Use when making git commits or generating consistent semantic commit messages.
title: "Semantic Commit"
summary: "Create semantic commits following sp_theory standards with interactive prompts"
read_when:
  - Making git commits
  - Following semantic commit standards
  - Generating consistent commit messages
status: active
last_updated: "2025-01-16"
---

# Semantic Commit

Interactive tool for creating semantic commits following sp_theory standards.

## Usage

```bash
# Interactive commit
semantic-commit

# Quick commit with type and message
semantic-commit feat "add user authentication"

# Commit with scope
semantic-commit fix "auth" "resolve login timeout issue"
```

## Commit Types

- **feat**: New features
- **fix**: Bug fixes
- **docs**: Documentation changes
- **style**: Code style changes
- **refactor**: Code refactoring
- **test**: Test additions/changes
- **chore**: Maintenance tasks

## Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```