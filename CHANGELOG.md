# Changelog

All notable changes to this project will be documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [0.3.0] - 2026-07-16

### Added

- `research-paper` skill — process academic papers (PDF or URL) into a knowledge base following the `sources → extract → analysis → studies → synthesis` pipeline
- `github-pages-setup` skill for setting up GitHub Pages with MkDocs Material and automatic deployment
- GitHub Pages documentation site with MkDocs Material theme
- Automatic deployment workflow for documentation updates

### Changed

- `agentctl` skill updated to v0.5.1 — added `--force` flag to `hub refresh` command for cache bypass
- README — skills listed as table, consistent formatting

## [0.2.0] - 2026-07-16

### Changed

- `agentctl` skill updated to v0.4.0 — expanded description, title, and `read_when` to cover hub registry, skill management, and config commands

## [0.1.0] - 2025-01-16

### Added
- Initial skills: `agentctl`, `python-scaffold`, `python-quality`, `semantic-commit`, `marker-pdf`, `asdf`, `jq`
- `index.json` generated via `agentctl`
- CI workflow publishing `index.json` on push to `main`
- `agentctl.toml` with hub id `geronimo-iia/agent-skills`
