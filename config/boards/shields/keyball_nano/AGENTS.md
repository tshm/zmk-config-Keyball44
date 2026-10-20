# Purpose

- Define the Keyball44 shield hardware for left and right halves.

# Ownership

- `keyball44.dtsi`: shared matrix transform, row pins, I2C bus, and SSD1306 OLED.
- Side overlays: column pins and right-side PMW3610 SPI device.
- Side `.conf` files: side-specific firmware options.
- Kconfig files and `keyball44.zmk.yml`: shield discovery, split roles, and display defaults.

# Local Contracts

- `keyball44_right` is central; `keyball44_left` is peripheral.
- OLED geometry is 128 by 32 pixels.
- Trackball layers are mouse 4, scroll 5, and snipe 6; keep them aligned with the keymap.
- Battery sensing is inherited from the controller board, not defined by these overlays.
- Keep `wakeup-source` on the shared `kscan0` matrix so keys can wake each half from idle deep sleep.

# Work Guidance

- Preserve physical pin assignments unless the hardware change is confirmed.

# Verification

- Build both shield targets through the root Makefile or firmware workflow.
- Verify pin, display, trackball, and battery changes on the physical keyboard.
- For sleep changes, unplug USB on both halves, leave idle for over 15 minutes, then press a key on each half and confirm wireless input resumes without USB.

# Child DOX Index

- None.
