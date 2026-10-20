# Purpose

- Own firmware build, keymap editing, diagram generation, and assistant automation.

# Ownership

- `edit.yml`: removes the obsolete pointing header after keymap changes.
- `build.yml`: manual build or build after the edit workflow completes; delegates to ZMK v0.3 with the root build matrix.
- `keymap_drawer.yml`: generates diagram assets using the root drawer configuration.
- `opencode.yml`: comment-triggered assistant integration.

# Local Contracts

- Firmware configuration changes outside the keymap do not directly trigger `build.yml`; use its manual dispatch when needed.
- Diagram outputs belong in `keymap-drawer/`.
- Keep credentials in GitHub secrets, not committed files.

# Work Guidance

# Verification

- Inspect the relevant GitHub Actions run and its firmware or diagram artifacts.

# Child DOX Index

- None.
