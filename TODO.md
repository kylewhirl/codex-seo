# TODO — codex-seo

## Deferred from February 2026 Research Report

Items identified during the Feb 2026 SEO research audit that require additional implementation work.

- [ ] **Fake freshness detection** (Priority: Medium)
  Compare visible dates (`datePublished`, `dateModified`) against actual content modification signals.
  Flag pages with updated dates but unchanged body content. This is a spam pattern Google targets.

- [ ] **Mobile content parity check** (Priority: Medium)
  Compare mobile vs desktop meta tags, structured data presence, and content completeness.
  Flag discrepancies that could affect mobile-first indexing. Currently only viewport/touch targets
  are checked, not content equivalence.

- [ ] **Discover optimization checks** (Priority: Low-Medium)
  Clickbait title detection, content depth scoring, local relevance signals, sensationalism flags.
  Relevant to Feb 2026 Discover Core Update which emphasizes original reporting and E-E-A-T signals.

- [ ] **Brand mention analysis Python implementation** (Priority: Low)
  Currently documented in `seo-geo/SKILL.md` but no programmatic scoring. Consider implementing
  a check that searches for brand entity presence signals (unlinked mentions, co-citation patterns,
  entity authority indicators).

---

*Last updated: February 2026*
