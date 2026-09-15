# 27 — Dependency and Supply Chain Security

## Purpose
Reduce risk from third-party packages, SDKs, build tools, and external artifacts.

## Policy
Use maintained dependencies with clear provenance and justified need. Avoid unnecessary packages and duplicate libraries.

## Versioning
Use lockfiles and controlled update processes. Security updates are prioritized; major upgrades are tested before adoption.

## Scanning
Run dependency vulnerability scanning and secret scanning in CI. Review critical findings promptly and document accepted residual risk.

## Provenance
Prefer official registries and verified sources. Protect CI credentials and build permissions.

## Runtime Providers
External AI and infrastructure providers are treated as dependencies with defined contracts, limits, failure behavior, and privacy review.

## Acceptance Criteria
- Dependency inventory is reproducible.
- Vulnerability scanning runs automatically.
- High-risk findings have owners.
- CI credentials use least privilege.
- Unnecessary dependencies are removed.

**Status:** Approved foundation document.