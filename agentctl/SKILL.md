---
name: agentctl
description: >-
  Validate and generate index.json for agent skill and doc hubs, manage hub registry,
  install/update/remove skills, and manage local agentctl config using agentctl.
  Use when maintaining hub directories, publishing hub indexes, managing installed skills,
  or configuring agentctl.
title: "agentctl Hub & Skill Management"
summary: "Validate hubs, generate indexes, manage skills and config with agentctl"
read_when:
  - Validating a skills or docs hub
  - Generating hub index.json
  - Publishing a hub to agent-foundation
  - Setting up CI for a hub repository
  - Installing, updating, or removing skills
  - Managing agentctl configuration
status: active
last_updated: "2026-07-16"
metadata:
  version: "0.4.0"
---

# agentctl Hub & Skill Management

Validates hub directories, generates `index.json`, manages hub registry, installs/updates/removes skills, and manages local config using [agentctl](https://github.com/geronimo-iia/agentctl).

## Install

```sh
brew tap geronimo-iia/agent && brew install agentctl
# or
cargo install agent-ctl
```

## Hub commands

```sh
# Validate
agentctl hub validate --type skills --path ./my-skills
agentctl hub validate --type docs --path ./my-docs

# Generate index.json
agentctl hub generate --type skills --path ./my-skills --output index.json
agentctl hub generate --type docs --path ./my-docs --output index.json

# Registry
agentctl hub add --type skills agent-skills https://raw.githubusercontent.com/org/repo/main/index.json --git-url https://github.com/org/repo
agentctl hub list
agentctl hub enable <id> / hub disable <id> / hub remove <id>
agentctl hub refresh [<id>]
```

## Skill commands

```sh
agentctl skill install <name> [--hub <id>] [--mode <mode>]
agentctl skill list
agentctl skill remove <name> --hub <id>
agentctl skill update [<name>] [--force]
```

**Global flags**: `--quiet` / `-q`, `--yes` / `-y`

## Config commands

```sh
agentctl config init          # create default ~/.agentctl/config.json
agentctl config show          # print full config
agentctl config path          # print config file path
agentctl config get skills_root
agentctl config set skills_root ~/.agent/skills
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
