---
name: python-scaffold
description: >-
  Scaffold new Python projects with modern toolchain (uv, ruff, pyright, pytest) following
  sp_theory standards. Use when starting a new Python project or setting up project structure.
title: "Python Project Scaffold"
summary: "Scaffold new Python projects with modern toolchain following sp_theory standards"
read_when:
  - Starting new Python projects
  - Need standard project structure
  - Setting up Python development environment
status: active
last_updated: "2025-01-16"
---

# Python Project Scaffold

Creates new Python projects following sp_theory standards with modern toolchain (uv, ruff, pyright, pytest).

## Usage

```bash
# Scaffold new project
python-scaffold create my-project

# Scaffold with description
python-scaffold create my-project --description "My awesome project"
```

## Generated Structure

```
my-project/
├── pyproject.toml
├── README.md
├── .gitignore
├── src/my_project/
│   ├── __init__.py
│   └── main.py
├── tests/
│   ├── __init__.py
│   └── test_main.py
└── .github/workflows/ci.yml
```

## Features

- Standard project structure
- Modern toolchain configuration
- GitHub Actions CI/CD
- Development dependencies
- Quality gates setup