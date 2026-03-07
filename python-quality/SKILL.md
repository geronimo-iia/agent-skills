---
name: python-quality
description: >-
  Run standardized Python quality checks: formatting, linting, type checking, and tests.
  Use when running code quality checks, pre-commit validation, or setting up CI/CD pipelines.
title: "Python Quality Checks"
summary: "Run standardized Python quality checks: formatting, linting, type checking, and tests"
read_when:
  - Running code quality checks
  - Pre-commit validation
  - CI/CD pipeline setup
status: active
last_updated: "2025-01-16"
---

# Python Quality Checks

Runs complete quality checks for Python projects following sp_theory standards.

## Usage

```bash
# Run all checks
python-quality check

# Run specific check
python-quality format
python-quality lint
python-quality types
python-quality test

# Fix issues automatically
python-quality fix
```

## Checks Performed

- **Format**: Code formatting with ruff
- **Lint**: Code linting with ruff
- **Types**: Type checking with pyright
- **Test**: Unit tests with pytest
- **Coverage**: Test coverage reporting

## Requirements

- uv package manager
- pyproject.toml with dev dependencies