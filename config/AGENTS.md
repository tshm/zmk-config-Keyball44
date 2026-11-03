# Purpose

- Own the Keyball44 keymap, shared firmware settings, dependency manifest, and editor layout.

# Ownership

- `keyball44.keymap`: key behaviors and seven layers.
- `keyball44.conf`: settings shared by both halves.
- `west.yml`: pinned upstream ZMK v0.3.0 and PMW3610 driver dependencies.
- `keyball44.json`: physical layout for keymap tooling.

# Local Contracts

- Right is the central/host-connected half; left is the peripheral.
- Both halves target nice!nano v2 in the root build matrix.
- USB Studio is enabled only on the right central; custom behaviors and trackball configuration remain firmware-defined.
- Battery fetching and proxying are already enabled in `keyball44.conf`; these expose the left battery to the host, not a second local OLED battery widget.
- Keep `dt-bindings/zmk/pointing.h` out of the keymap; the editor workflow removes that obsolete include.
- In Auto Mouse mode, holding Space exits MOUSE and keeps NUM active until release; tapping Space types a space and returns to DEFAULT. `mo_exit_aml` must exit MOUSE before activating its target layer.

## Studio Migration Invariants

- Keep the seven layers in this order: `DEFAULT`, `NUM`, `SYM`, `FUN`, `MOUSE`, `SCROLL`, `SNIPE`; the pointer driver uses the fixed `MOUSE`/`SCROLL`/`SNIPE` indices.
- Preserve the right top bootloader combo at positions `10 11 9`; the right second-row combo at positions `21 22 23` is reserved for `&studio_unlock`.

# Work Guidance

- Read the shield contract before changing hardware settings.
- Do not change battery ADC wiring or scaling without identifying the actual controller and measurement circuit.

# Verification

- Root `make` builds both halves with Podman and the local west workspace.
- GitHub Actions builds the entries in `build.yaml` through the upstream ZMK workflow.
- Battery accuracy requires on-device measurements; a successful build cannot verify it.

# Child DOX Index

- [boards/shields/keyball_nano/AGENTS.md](boards/shields/keyball_nano/AGENTS.md): matrix, OLED, split roles, and right-side trackball hardware.
