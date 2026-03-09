# Configuration Examples

## Basic Documentation Site

Simple setup for a standard documentation repository:

```yaml
site_name: My Project Docs
site_description: Documentation for My Project
site_url: https://username.github.io/my-project/
repo_url: https://github.com/username/my-project

theme:
  name: material
  palette:
    - scheme: default
      primary: blue

plugins:
  - search

nav:
  - Home: README.md
  - Getting Started: getting-started.md
  - API Reference: api.md
```

## Multi-Domain Documentation

For projects with organized domain structure:

```yaml
site_name: Agent Foundation
site_description: Specifications for multi-agent systems

theme:
  name: material
  features:
    - navigation.tabs
    - navigation.sections
    - navigation.expand

nav:
  - Home: README.md
  - Bootstrap:
    - Definition: bootstrap/definition.md
    - Setup Guide: bootstrap/setup.md
  - Skills:
    - Definition: skills/definition.md
    - Authoring: skills/authoring.md
  - Agents:
    - Definition: agents/definition.md
    - Manifests: agents/manifests.md
```

## Custom Directory Structure

When using a custom docs directory:

```yaml
site_name: My Project
docs_dir: mkdocs_temp  # Custom directory

theme:
  name: material

# GitHub Actions will copy files to mkdocs_temp
```

## Advanced Features

Full-featured configuration with all options:

```yaml
site_name: Advanced Project
site_description: Full-featured documentation site
site_url: https://username.github.io/project/
repo_url: https://github.com/username/project

docs_dir: docs
site_dir: site

theme:
  name: material
  palette:
    - scheme: default
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    - scheme: slate
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-4
        name: Switch to light mode
  features:
    - navigation.tabs
    - navigation.sections
    - navigation.expand
    - navigation.path
    - navigation.top
    - search.highlight
    - search.share
    - content.code.copy
    - content.code.annotate

plugins:
  - search:
      lang: en
  - mermaid2
  - git-revision-date-localized:
      type: date

markdown_extensions:
  - admonition
  - pymdownx.details
  - pymdownx.superfences:
      custom_fences:
        - name: mermaid
          class: mermaid
          format: !!python/name:pymdownx.superfences.fence_code_format
  - pymdownx.highlight:
      anchor_linenums: true
  - pymdownx.inlinehilite
  - pymdownx.snippets
  - attr_list
  - md_in_html
  - toc:
      permalink: true

extra:
  social:
    - icon: fontawesome/brands/github
      link: https://github.com/username
    - icon: fontawesome/brands/twitter
      link: https://twitter.com/username

copyright: Copyright &copy; 2025 Your Name
```

## Ignore Patterns

Example `.mkdocsignore` file:

```
# Build artifacts
node_modules/
.git/
.github/
site/
mkdocs_temp/

# Development files
*.pyc
__pycache__/
.env
.venv/

# Documentation excludes
TODO.md
NOTES.md
drafts/
```

## Repository Settings

Required GitHub repository settings:

1. **Pages Configuration**:
   - Source: GitHub Actions
   - Custom domain (optional): your-domain.com

2. **Actions Permissions**:
   - Allow GitHub Actions
   - Allow actions created by GitHub

3. **Branch Protection** (optional):
   - Require status checks
   - Require branches to be up to date