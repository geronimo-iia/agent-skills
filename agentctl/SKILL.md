---
name: agentctl
description: >-
  Validate and generate index.json for agent skill and doc hubs using agentctl.
  Use when maintaining hub directories or publishing hub indexes.
title: "agentctl Hub Management"
summary: "Validate and generate index.json for agent skill and doc hubs"
read_when:
  - Validating a skills or docs hub
  - Generating hub index.json
  - Publishing a hub to agent-foundation
  - Setting up CI for a hub repository
status: active
last_updated: "2026-07-14"
metadata:
  version: "0.2.0"
---

# agentctl Hub Management

Validates hub directories and generates `index.json` using [agentctl](https://github.com/geronimo-iia/agentctl).

## Install

```sh
brew tap geronimo-iia/agent && brew install agentctl
# or
cargo install agent-ctl
```

## Validate a hub

```sh
# Skills hub
agentctl hub validate --type skills --path ./my-skills

# Docs hub
agentctl hub validate --type docs --path ./my-docs
```

On failure (exit code 1):
```
  ✗ my-skills/bad-skill/SKILL.md:1: missing required field: name
✗ Validation failed (1 error(s))
```

## Generate index.json

```sh
agentctl hub generate --type skills --path ./my-skills --output index.json
agentctl hub generate --type docs --path ./my-docs --output index.json
```

## CI integration

```yaml
jobs:
  publish:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4

      - name: Install agentctl
        run: |
          curl -sSL https://github.com/geronimo-iia/agentctl/releases/latest/download/x86_64-unknown-linux-gnu.tar.gz \
            | tar xz -C /usr/local/bin

      - name: Validate
        run: agentctl hub validate --type skills --path .

      - name: Generate index.json
        run: agentctl hub generate --type skills --path . --output index.json

      - name: Commit index.json
        if: github.ref == 'refs/heads/main' && github.event_name == 'push'
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add index.json
          git diff --staged --quiet || git commit -m "chore: regenerate index.json [skip ci]"
          git push
```

## Skills hub rules

- Each skill in its own directory with a `SKILL.md` file
- Required frontmatter fields: `name`, `description`
- Flat hierarchy — no nested skill directories
- Hidden directories (`.git`) are ignored

## Docs hub rules

- Required frontmatter fields: `title`, `summary`, `status`, `last_updated`, `read_when`
- `read_when` must be a non-empty list
