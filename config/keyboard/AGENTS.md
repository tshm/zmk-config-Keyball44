# Purpose

- Own the project-local Zephyr module and keyboard shield sources.

# Ownership

- `zephyr/module.yml`: registers this directory as the project module and its board root.
- `boards/`: project-owned boards and shields, including the Keyball44 hardware contract.

# Local Contracts

- Keep project shield sources under `boards/` so Zephyr discovers them through this module.
- The root keymap, shared firmware configuration, dependency manifest, and editor layout remain owned by `config/AGENTS.md`.

# Work Guidance

- Preserve the shield's physical pins, matrix behavior, display, trackball, and wake behavior when changing module files.

# Verification

- Build both shield targets through the root Makefile or firmware workflow.

# Child DOX Index

- [boards/shields/keyball_nano/AGENTS.md](boards/shields/keyball_nano/AGENTS.md): Keyball44 matrix, OLED, split roles, and right-side trackball hardware.
