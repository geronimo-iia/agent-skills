# Agent Skills

Collection of skills for agent systems. Each skill provides specific capabilities that agents can discover, load, and execute.

## Skills

| Skill | Description |
|---|---|
| [agentctl](agentctl/SKILL.md) | Validate and generate hub indexes, manage hub registry, install/update/remove skills, manage local config |
| [research-paper](research-paper/SKILL.md) | Process academic papers (PDF or URL) into a knowledge base via extract → analysis → synthesis pipeline |
| [marker-pdf](marker-pdf/SKILL.md) | Convert PDFs, images, PPTX, DOCX, XLSX, HTML, EPUB to markdown, JSON, or HTML with OCR and table support |
| [python-scaffold](python-scaffold/SKILL.md) | Scaffold a new Python project with modern toolchain (uv, ruff, pyright, pytest) |
| [python-quality](python-quality/SKILL.md) | Run Python code quality checks — formatting, linting, type checking, and tests |
| [semantic-commit](semantic-commit/SKILL.md) | Create semantic commits with interactive prompts following sp_theory standards |
| [github-pages-setup](github-pages-setup/SKILL.md) | Set up GitHub Pages with MkDocs Material and automatic deployment workflow |
| [asdf](asdf/SKILL.md) | Manage multiple runtime versions (Python, Node.js, Go, etc.) per project |
| [jq](jq/SKILL.md) | Query, filter, transform, and format JSON from the command line |

## Skill Development

Skills follow the [agent-foundation skills specification](https://geronimo-iia.github.io/agent-foundation/skills/authoring-guide/):

- `SKILL.md` with machine-readable YAML frontmatter
- `lifecycle.yaml` for install/update/uninstall
- `scripts/` for helper scripts (optional)
- `assets/` for Python/code examples (optional)
- `references/` for detailed documentation (optional)
- Use `SKILL_PATH` variable provided by agent

For complete authoring guidelines, see [agent-foundation skills authoring guide](https://geronimo-iia.github.io/agent-foundation/skills/authoring-guide/).

## Organization

- Each skill in its own directory
- Named descriptively (e.g., `marker-pdf`, `asdf`)
- Self-contained with lifecycle.yaml
- Compatible with agent skill discovery systems
- Minimal structure - only include necessary files

## License

[MIT](LICENSE.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).