# GitHub Pages Troubleshooting Guide

## Common Issues and Solutions

### Navigation Not Appearing

**Problem**: Navigation menu is empty or not showing expected structure.

**Solutions**:
1. Check file paths in `mkdocs.yml` nav section are correct
2. Ensure markdown files exist at specified paths
3. Run `./scripts/generate-navigation.py` to regenerate navigation
4. Verify YAML syntax in mkdocs.yml is valid

### Mermaid Diagrams Not Rendering

**Problem**: Mermaid diagrams show as code blocks instead of rendered diagrams.

**Solutions**:
1. Ensure `mkdocs-mermaid2-plugin` is installed
2. Check that mermaid2 is listed in plugins section of mkdocs.yml
3. Verify mermaid code blocks use correct syntax:
   ```markdown
   ```mermaid
   graph TD
       A --> B
   ```
4. Check browser console for JavaScript errors

### Build Failures in GitHub Actions

**Problem**: GitHub Actions workflow fails during build step.

**Solutions**:
1. Check Actions logs for specific error messages
2. Verify all required dependencies are installed
3. Ensure Python version compatibility (use Python 3.x)
4. Check for syntax errors in mkdocs.yml
5. Verify all referenced files exist

### Custom Domain Issues

**Problem**: Custom domain not working or showing 404 errors.

**Solutions**:
1. Add CNAME file to repository root with your domain
2. Configure DNS records (A or CNAME) pointing to GitHub Pages
3. Enable "Enforce HTTPS" in repository settings
4. Wait for DNS propagation (can take up to 24 hours)

### Files Not Copying to mkdocs_temp

**Problem**: When using custom docs_dir, files are missing from build.

**Solutions**:
1. Check file paths in GitHub Actions workflow
2. Verify find command patterns match your file structure
3. Add specific file types to copy command if needed
4. Check for permission issues or special characters in filenames

### Search Not Working

**Problem**: Search functionality returns no results or is not available.

**Solutions**:
1. Ensure search plugin is enabled in mkdocs.yml
2. Check that content is being indexed (build logs show indexing)
3. Verify JavaScript is enabled in browser
4. Clear browser cache and rebuild site

### Slow Build Times

**Problem**: GitHub Actions builds take too long or timeout.

**Solutions**:
1. Enable dependency caching in workflow
2. Reduce number of files being copied
3. Optimize image sizes and file counts
4. Use .mkdocsignore file to exclude unnecessary files

### Theme Not Loading Correctly

**Problem**: Site appears unstyled or uses default theme.

**Solutions**:
1. Verify Material theme is installed: `pip install mkdocs-material`
2. Check theme configuration in mkdocs.yml
3. Ensure no conflicting CSS files
4. Clear browser cache

### Links Broken After Deployment

**Problem**: Internal links return 404 errors on deployed site.

**Solutions**:
1. Use relative paths for internal links
2. Ensure linked files are included in build
3. Check case sensitivity (GitHub Pages is case-sensitive)
4. Verify file extensions are included in links

## Debugging Steps

1. **Local Testing**: Always test locally with `mkdocs serve` before pushing
2. **Build Logs**: Check GitHub Actions logs for detailed error messages
3. **File Structure**: Verify all referenced files exist and paths are correct
4. **YAML Validation**: Use online YAML validators to check mkdocs.yml syntax
5. **Browser Tools**: Use browser developer tools to check for JavaScript errors

## Getting Help

- MkDocs Documentation: https://www.mkdocs.org/
- Material Theme Docs: https://squidfunk.github.io/mkdocs-material/
- GitHub Pages Docs: https://docs.github.com/en/pages
- GitHub Actions Docs: https://docs.github.com/en/actions