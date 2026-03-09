---
name: github-pages-setup
description: >-
  Set up GitHub Pages with MkDocs Material for documentation sites with automatic deployment.
  Use when creating documentation websites, setting up project documentation, or deploying
  markdown content to GitHub Pages. Do not use for static HTML sites or Jekyll projects.
compatibility: Requires GitHub repository with Actions enabled
---

# GitHub Pages Setup

## Setup process

1. **Create MkDocs configuration**:
   - Copy `assets/mkdocs-template.yml` to `mkdocs.yml`
   - Update site_name, site_url, repo_url with your project details
   - Customize navigation structure for your content

2. **Set up GitHub Actions**:
   - Copy `assets/github-actions-template.yml` to `.github/workflows/pages-build-deployment.yml`

3. **Configure GitHub Pages**:
   - Go to repository Settings → Pages
   - Set Source to "GitHub Actions"
   - Optionally add custom domain in "Custom domain" field

## File structure created

```
project/
├── mkdocs.yml                                    # MkDocs configuration
├── .github/workflows/
│   └── pages-build-deployment.yml              # GitHub Actions deployment
└── mkdocs_temp/                                 # Custom docs directory (auto-created)
```

## Troubleshooting

Common issues and solutions:
- **Navigation not appearing**: Check file paths in mkdocs.yml nav section
- **Mermaid not rendering**: Ensure mermaid2 plugin is installed and configured
- **Build failures**: Check GitHub Actions logs for missing dependencies
- **Custom domain issues**: Verify CNAME file and DNS configuration

## Related skills

- `semantic-commit`: For proper commit messages when setting up
- `python-scaffold`: If creating Python documentation projects