# Agent Skills

Collection of skills for agent systems. Each skill provides specific capabilities that agents can discover, load, and execute.

## Skills

### agentctl
CLI for agent hub validation and index generation. Validates skill and doc hub directories and generates `index.json`.

**Capabilities:**
- Validate skills hub (`name`, `description`, flat hierarchy)
- Validate docs hub (`title`, `summary`, `status`, `last_updated`, `read_when`)
- Generate `index.json` with git commit hashes
- CI integration with exit code 0/1

### python-scaffold
Scaffold a new Python project with standard structure, tooling, and configuration.

### python-quality
Run Python code quality checks — linting, formatting, and type checking.

### semantic-commit
Create semantic commits following sp_theory standards with interactive prompts.

### marker-pdf
Document conversion skill using Marker. Converts PDFs, images, PPTX, DOCX, XLSX, HTML, and EPUB files to markdown, JSON, chunks, and HTML with high accuracy.

**Capabilities:**
- Text extraction with OCR
- Table and equation formatting
- Image extraction and linking
- Batch processing with chunking
- LLM-enhanced accuracy mode

### asdf
Version manager for multiple runtimes. Manages Python, Node.js, Go, and other language versions per project using .tool-versions files.

**Capabilities:**
- Install and switch runtime versions
- Per-project version management
- Global and local version configuration
- Plugin ecosystem for many languages

### jq
JSON processor for command line. Query, filter, transform, and format JSON data.

**Capabilities:**
- Parse and pretty-print JSON
- Extract fields and filter arrays
- Transform JSON structures
- Pipe-friendly command-line interface

**Dependencies:** Requires asdf skill

## Skill Development

Skills follow the [agent-foundation skills specification](../agent-foundation/skills/authoring-guide.md):
- `SKILL.md` with machine-readable YAML frontmatter
- `lifecycle.yaml` for install/update/uninstall
- `scripts/` for helper scripts (optional)
- `assets/` for Python/code examples (optional)
- `references/` for detailed documentation (optional)
- Use `SKILL_PATH` variable provided by agent

For complete authoring guidelines, see [../agent-foundation/skills/authoring-guide.md](../agent-foundation/skills/authoring-guide.md).

## Organization

- Each skill in its own directory
- Named descriptively (e.g., `marker-pdf`, `asdf`)
- Self-contained with lifecycle.yaml
- Compatible with agent skill discovery systems
- Minimal structure - only include necessary files

## License

[MIT](LICENSE)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).