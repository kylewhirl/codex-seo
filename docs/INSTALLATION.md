# Installation Guide

> Original project credit: [@AgriciDaniel](https://github.com/AgriciDaniel), Claude repo: https://github.com/AgriciDaniel/claude-seo. Codex build and this maintained fork: [@kylewhirl](https://github.com/kylewhirl).

## Prerequisites

- **Python 3.8+** with pip
- **Git** for cloning the repository
- **Codex CLI** installed and configured

Optional:
- **Playwright** for screenshot capabilities

## Quick Install

### Unix/macOS/Linux

```bash
curl -fsSL https://raw.githubusercontent.com/kylewhirl/codex-seo/main/install.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/kylewhirl/codex-seo/main/install.ps1 | iex
```

## Manual Installation

1. **Clone the repository**

```bash
git clone https://github.com/kylewhirl/codex-seo.git
cd codex-seo
```

2. **Run the installer**

```bash
./install.sh
```

3. **Install Python dependencies** (if not done automatically)

```bash
pip install -r requirements.txt
```

4. **Install Playwright browsers** (optional, for screenshots)

```bash
pip install playwright
playwright install chromium
```

## Installation Paths

The installer copies files to:

| Component | Path |
|-----------|------|
| Main skill | `~/.codex/skills/seo/` |
| Sub-skills | `~/.codex/skills/seo-*/` |
| Subagents | `~/.codex/agents/seo-*.md` |

## Verify Installation

1. Start Codex CLI:

```bash
codex
```

2. Check that the skill is loaded:

```
$seo
```

You should see a help message or prompt for a URL.

## Uninstallation

```bash
curl -fsSL https://raw.githubusercontent.com/kylewhirl/codex-seo/main/uninstall.sh | bash
```

Or manually:

```bash
rm -rf ~/.codex/skills/seo
rm -rf ~/.codex/skills/seo-audit
rm -rf ~/.codex/skills/seo-competitor-pages
rm -rf ~/.codex/skills/seo-content
rm -rf ~/.codex/skills/seo-geo
rm -rf ~/.codex/skills/seo-hreflang
rm -rf ~/.codex/skills/seo-images
rm -rf ~/.codex/skills/seo-page
rm -rf ~/.codex/skills/seo-plan
rm -rf ~/.codex/skills/seo-programmatic
rm -rf ~/.codex/skills/seo-schema
rm -rf ~/.codex/skills/seo-sitemap
rm -rf ~/.codex/skills/seo-technical
rm -f ~/.codex/agents/seo-*.md
```

## Upgrading

To upgrade to the latest version:

```bash
# Uninstall current version
curl -fsSL https://raw.githubusercontent.com/kylewhirl/codex-seo/main/uninstall.sh | bash

# Install new version
curl -fsSL https://raw.githubusercontent.com/kylewhirl/codex-seo/main/install.sh | bash
```

## Troubleshooting

### "Skill not found" error

Ensure the skill is installed in the correct location:

```bash
ls ~/.codex/skills/seo/SKILL.md
```

If the file doesn't exist, re-run the installer.

### Python dependency errors

Install dependencies manually:

```bash
pip install beautifulsoup4 requests lxml playwright Pillow urllib3 validators
```

### Playwright screenshot errors

Install Chromium browser:

```bash
playwright install chromium
```

### Permission errors on Unix

Make sure scripts are executable:

```bash
chmod +x ~/.codex/skills/seo/scripts/*.py
chmod +x ~/.codex/skills/seo/hooks/*.py
chmod +x ~/.codex/skills/seo/hooks/*.sh
```
