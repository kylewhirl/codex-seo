#!/usr/bin/env bash
set -euo pipefail

# Codex SEO Installer
# Wraps everything in main() to prevent partial execution on network failure

main() {
    CODEX_HOME_DIR="${CODEX_HOME:-${HOME}/.codex}"
    SKILL_DIR="${CODEX_HOME_DIR}/skills/seo"
    AGENT_DIR="${CODEX_HOME_DIR}/agents"
    REPO_URL="https://github.com/AgriciDaniel/codex-seo"

    echo "════════════════════════════════════════"
    echo "║   Codex SEO - Installer             ║"
    echo "║   Codex CLI SEO Skill              ║"
    echo "════════════════════════════════════════"
    echo ""

    # Check prerequisites
    command -v python3 >/dev/null 2>&1 || { echo "✗ Python 3 is required but not installed."; exit 1; }
    command -v git >/dev/null 2>&1 || { echo "✗ Git is required but not installed."; exit 1; }

    # Check Python version
    PYTHON_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
    echo "✓ Python ${PYTHON_VERSION} detected"

    # Create directories
    mkdir -p "${SKILL_DIR}"
    mkdir -p "${AGENT_DIR}"

    # Clone or update
    TEMP_DIR=$(mktemp -d)
    trap "rm -rf ${TEMP_DIR}" EXIT

    echo "↓ Downloading Codex SEO..."
    git clone --depth 1 "${REPO_URL}" "${TEMP_DIR}/codex-seo" 2>/dev/null

    # Copy skill files
    echo "→ Installing skill files..."
    cp -r "${TEMP_DIR}/codex-seo/seo/"* "${SKILL_DIR}/"

    # Copy sub-skills
    if [ -d "${TEMP_DIR}/codex-seo/skills" ]; then
        for skill_dir in "${TEMP_DIR}/codex-seo/skills"/*/; do
            skill_name=$(basename "${skill_dir}")
            target="${CODEX_HOME_DIR}/skills/${skill_name}"
            mkdir -p "${target}"
            cp -r "${skill_dir}"* "${target}/"
        done
    fi

    # Copy schema templates
    if [ -d "${TEMP_DIR}/codex-seo/schema" ]; then
        mkdir -p "${SKILL_DIR}/schema"
        cp -r "${TEMP_DIR}/codex-seo/schema/"* "${SKILL_DIR}/schema/"
    fi

    # Copy reference docs
    if [ -d "${TEMP_DIR}/codex-seo/pdf" ]; then
        mkdir -p "${SKILL_DIR}/pdf"
        cp -r "${TEMP_DIR}/codex-seo/pdf/"* "${SKILL_DIR}/pdf/"
    fi

    # Copy agents
    echo "→ Installing subagents..."
    cp -r "${TEMP_DIR}/codex-seo/agents/"*.md "${AGENT_DIR}/" 2>/dev/null || true

    # Copy shared scripts
    if [ -d "${TEMP_DIR}/codex-seo/scripts" ]; then
        mkdir -p "${SKILL_DIR}/scripts"
        cp -r "${TEMP_DIR}/codex-seo/scripts/"* "${SKILL_DIR}/scripts/"
    fi

    # Copy hooks
    if [ -d "${TEMP_DIR}/codex-seo/hooks" ]; then
        mkdir -p "${SKILL_DIR}/hooks"
        cp -r "${TEMP_DIR}/codex-seo/hooks/"* "${SKILL_DIR}/hooks/"
        chmod +x "${SKILL_DIR}/hooks/"*.sh 2>/dev/null || true
        chmod +x "${SKILL_DIR}/hooks/"*.py 2>/dev/null || true
    fi

    # Install Python dependencies
    echo "→ Installing Python dependencies..."
    pip install --quiet --break-system-packages -r "${TEMP_DIR}/codex-seo/requirements.txt" 2>/dev/null || \
    pip install --quiet -r "${TEMP_DIR}/codex-seo/requirements.txt" 2>/dev/null || \
    echo "⚠  Could not auto-install Python packages. Run: pip install -r requirements.txt"

    # Optional: Install Playwright browsers
    echo "→ Installing Playwright browsers (optional)..."
    python3 -m playwright install chromium 2>/dev/null || \
    echo "⚠  Playwright browser install failed. Screenshots won't work. Run: playwright install chromium"

    echo ""
    echo "✓ Codex SEO installed successfully!"
    echo ""
    echo "Usage:"
    echo "  1. Start Codex CLI:  codex"
    echo "  2. Run commands:       /seo audit https://example.com"
    echo ""
    echo "To uninstall: curl -fsSL https://raw.githubusercontent.com/AgriciDaniel/codex-seo/main/uninstall.sh | bash"
}

main "$@"
