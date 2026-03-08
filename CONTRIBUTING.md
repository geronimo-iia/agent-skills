# Contributing

## Adding a skill

Each skill lives in its own directory and must follow the skill authoring standard:

- [Skill Authoring](../agent-foundation/skills/authoring-guide.md) — `SKILL.md` frontmatter schema, required fields
- [Lifecycle YAML Format](../agent-foundation/skills/lifecycle-format.md) — `lifecycle.yaml` spec for install/update/uninstall

## Skill structure

```
<skill-name>/
├── SKILL.md          # required — frontmatter + description
├── lifecycle.yaml    # required — install/update/uninstall steps
├── scripts/          # optional — helper scripts
└── assets/           # optional — supporting files
```

## Commit format

Follow the semantic commit standard from [agent-software](../agent-software/version-control-release/git-commit-semantic.md).

## Index

`index.json` is auto-generated — do not edit it manually. It is regenerated on every push to `main`.
