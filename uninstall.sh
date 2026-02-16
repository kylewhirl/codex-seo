#!/usr/bin/env bash
set -euo pipefail

main() {
    CODEX_HOME_DIR="${CODEX_HOME:-${HOME}/.codex}"

    echo "→ Uninstalling Codex SEO..."

    # Remove main skill
    rm -rf "${CODEX_HOME_DIR}/skills/seo"

    # Remove sub-skills
    for skill in seo-audit seo-competitor-pages seo-content seo-geo seo-hreflang seo-images seo-page seo-plan seo-programmatic seo-schema seo-sitemap seo-technical; do
        rm -rf "${CODEX_HOME_DIR}/skills/${skill}"
    done

    # Remove agents
    for agent in seo-technical seo-content seo-schema seo-sitemap seo-performance seo-visual; do
        rm -f "${CODEX_HOME_DIR}/agents/${agent}.md"
    done

    echo "✓ Codex SEO uninstalled."
}

main "$@"
