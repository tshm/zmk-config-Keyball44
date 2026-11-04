# Purpose

- Own firmware build, keymap editing, diagram generation, and assistant automation.

# Ownership

- `edit.yml`: removes the obsolete pointing header after keymap changes.
- `build.yml`: manual build or build after the edit workflow completes; delegates to the checked-in reusable workflow with the root build matrix.
- `build-user-config.yml`: firmware build and artifact merge, based on the ZMK v0.3.0 workflow without changing the manifest's firmware revisions.
- `keymap_drawer.yml`: generates diagram assets using the root drawer configuration.
- `opencode.yml`: comment-triggered assistant integration.

# Local Contracts

- `build.yml` calls the checked-in `build-user-config.yml`; that reusable workflow is based on `zmkfirmware/zmk/.github/workflows/build-user-config.yml@v0.3.0`.
- The local reusable workflow loads the project-owned `config/keyboard` module with `-DZMK_EXTRA_MODULES=${GITHUB_WORKSPACE}/config/keyboard` and keeps the root-module isolation path for upstream-compatible configurations.
- Keep Node24-native actions in local workflows: checkout v6, cache v5, upload-artifact and upload-artifact/merge v6, git-auto-commit-action v7. The drawer reusable workflow has its own reviewed action versions.
- `edit.yml` requires only `contents: write` for its existing auto-commit token flow; do not broaden permissions in other workflows.

- Firmware configuration changes outside the keymap do not directly trigger `build.yml`; use its manual dispatch when needed.
- Diagram outputs belong in `keymap-drawer/`.
- Keep credentials in GitHub secrets, not committed files.

# Work Guidance

# Verification

- Inspect the relevant GitHub Actions run and its firmware or diagram artifacts.
- `go run github.com/rhysd/actionlint/cmd/actionlint@latest` validates workflow syntax and reusable-workflow contracts locally.

# Child DOX Index

- None.
