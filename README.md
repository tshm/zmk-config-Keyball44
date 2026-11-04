This keeb created by a group of people who loves keyball.

Special Thanks to:
PCB: *[yangxing844](https://github.com/yangxing844)*
Case: *[delock](https://github.com/delock)*
Firmware: *[Amos698](https://github.com/Amos698)*

# XCMKB session

Thanks for the above contribution and *[inorichi](https://github.com/inorichi/zmk-pmw3610-driver)* too.

## Quick Link

[Keymap Editor](https://nickcoutsos.github.io/keymap-editor/)
[Github, Keymap Editor Setup and Flashing](https://github.com/superxc3/zmk_config_sofle#steps) - using Sofle wireless as reference

## Attention on Mousekeys Configuration

There will be compilation failed if you using Keymap Editor, this happens due to zmk mousekey update.
Please go to `config/keyball44.keymap` and delete this line `#include <dt-bindings/zmk/pointing.h>` every time you finish configuring the keymap in the Keymap Editor. Refer to this [link](https://xcmkb-docs.gitbook.io/doc/user-manual/keyball61-wireless#keymap-editor-dec24-compilation-error) for detailed troubleshoot.

## ZMK Studio

- Firmware targets upstream ZMK v0.3.0 and nice!nano v2 (`nice_nano_v2`), retaining the pinned PMW3610 driver and existing trackball tuning.
- Connect the **right half** to USB and open [ZMK Studio](https://zmk.studio/) in Chrome/Edge or the native app. On Linux, the user needs access to the USB serial device.
- The rightmost three keys in the **top row** still enter the bootloader (positions 9, 10, 11). The three keys immediately below them **unlock Studio** (positions 21, 22, 23). Press all three together.
- If both Bluetooth and USB are connected, select USB output before using Studio over USB.
- Keep the seven layers in their existing order: the trackball driver uses fixed layer indices 4/5/6. Studio can assign existing behaviors, but custom macros, combos, conditional layers, and sensor settings remain firmware-defined.
- Studio saves keymap changes on the keyboard. Later firmware `.keymap` edits require **Restore Stock Settings** in Studio to take effect; that discards Studio keymap customizations.
- Flash **both halves** for this firmware migration. The pre-migration configuration is preserved on GitHub as tag `pre-zmk-studio-2026-11-02`; restore matching firmware for both halves when rolling back. Settings-reset firmware clears saved settings and should only be used deliberately.
- Physical-layout coordinate-only fixes need the right central reflashed and Studio reconnected; they do not require Restore Stock Settings or change key bindings. Thumb-key rotations use each key's own center for compatibility with the deployed Studio renderer.

### Local Build

Run `make` with Podman available. It updates west dependencies when `config/west.yml` changes and produces `build/firmware_right.uf2`, `build/firmware_left.uf2`, and `build/settings_reset.uf2`. Use `make west-update` to explicitly refresh dependencies.

Builds start pristine when inputs change to avoid retaining the old board or missing the Studio USB snippet. Unchanged builds are skipped.

The shield lives in the Zephyr module at `config/keyboard/`; both local builds and the local reusable Actions workflow load it through `ZMK_EXTRA_MODULES`. The keymap, shared settings, and dependency manifest stay directly under `config/`.

After flashing both halves, verify the two right-hand combos, Studio save/power-cycle persistence, all 44 keys, trackball mouse/scroll/snipe behavior, OLED/battery reporting, and unplugged sleep/wake. A successful build does not verify hardware behavior.

### Build Warnings

Project workflows use Node24-native actions without upgrading the pinned firmware dependencies. The Ubuntu runner migration notice is informational; firmware builds already pass on Ubuntu 26.04.

The pinned upstream firmware still emits these warnings:

- `NRF_STORE_REBOOT_TYPE_GPREGRET` is deprecated but retained for nRF52 bootloader compatibility.
- The right-only PMW3610 module creates an empty CMake library on left/settings-reset builds.
- The upstream settings-reset mock scanner has zero rows but a one-binding keymap, producing initializer/array-bounds warnings. Correcting this needs a focused upstream fix or durable backport and a physical settings-reset check, not warning suppression.

## Notes

### Flashing

1. A stock keymap-only update normally needs only the right central. If Studio has saved a keymap, use Restore Stock Settings for firmware keymap edits to take effect. Firmware/platform or hardware changes require flashing both halves.
2. Hold the red button and double tap the green button quickly to call out the bootloader. If this cant work, unscrew the oled cover and double press the reset button twice. If double press doesn’t call out the new folder to drag your UF2, check MY COMPUTER for any new drive, or you may need to double press even faster.
3. You don’t need to delete any files in the nicenano folder. Extract the `firmware.zip`, you will get `keyball44_right-nice_nano_v2-zmk.uf2` - drag this to the nicenano folder. Ignore and skip any errors.
4. If left oled shows a cross button, you will need to drop `keyball44_left-nice_nano_v2-zmk.uf2` to the left too. Proceed to flash the left by following Step2 to 4. Ignore and skip any errors.
5. This `settings_reset-nice_nano_v2-zmk.uf2` is a backup uf2 to reset everything, you dont need this unless you know what you are doing.
6. Normally, you don’t need to re-pair after formatting. It will pair automatically.

The three-key bootloader combo above remains available; the physical reset button is the fallback if firmware is not responding.

### Charging

1. You can just plug in cable and flip the power button on to charge. Push to left on both sides to turn on the keyboard.
2. You can charge both sides togehter. Slave (left) normally lasts longer than the master (right).
3. If you want to make sure flawless connection, you can plug in cable to right and use as wired mode. Left doesnt need to plug in wire and remains wireless.
4. If you want to keep your battery healthy yet want to make sure flawless connection, you can flip the power button off and plug in cable to right. This makes sure the board is using in wired mode but doesnt always charge the battery.

### Sleep and Wake

- Each half enters deep sleep after 15 minutes without activity while USB is disconnected.
- The key matrix is a wake source on both halves. Press a key on each half to wake both; a sleeping half cannot be woken by the other half over Bluetooth.
- Flash **both halves** when updating sleep/wake hardware configuration, not just the right-hand central.
- To verify, disconnect USB from both halves, leave them idle for over 15 minutes, then press keys on each half and confirm wireless input resumes without reconnecting USB.

### Switch Installation

1. Please note that thumb area switch is upside down compare to the other zones.
2. Thumb supports v1 and v2 choc sockets too. You have to change the switch plate and shorter screw provided in the package.

## Trackball Layer

1. `Auto Mouse`: Layer 4 (moving the trackball enables it through the PMW3610 automouse layer. Non-mouse positions exit to the base layer; layer-tap holds then activate their target layer until release. Hold Space for NUM; tap Space to type a space and return to base. Click/page/scroll-entry positions stay on the mouse workflow).
2. `Scroll`: Layer 5
3. `Snipe`: Layer 6 (cursor moves super slow for precision)

## Trackball Configuration

1. To change the Scroll Layer, edit `scroll-layers = <5>;` in [`config/keyboard/boards/shields/keyball_nano/keyball44_right.overlay`](config/keyboard/boards/shields/keyball_nano/keyball44_right.overlay).
2. To change CPI, edit `CONFIG_PMW3610_CPI=1200` in [`config/keyboard/boards/shields/keyball_nano/keyball44_right.conf`](config/keyboard/boards/shields/keyball_nano/keyball44_right.conf). Snipe CPI, scroll direction, and other trackball settings live in the same file.
3. To turn off the Auto Mouse layer, edit `config/keyboard/boards/shields/keyball_nano/keyball44_right.overlay` and comment out or remove `automouse-layer = <4>;`.
4. To change the Auto Mouse timeout, edit `CONFIG_PMW3610_AUTOMOUSE_TIMEOUT_MS=700` in `config/keyboard/boards/shields/keyball_nano/keyball44_right.conf`.
5. The immediate-exit behavior for non-mouse keys is defined in `config/keyball44.keymap` by the `exit_aml`, `kp_exit_aml`, `mt_exit_aml`, and `lt_exit_aml` helper behaviors.

## Default Keymap

<img src="keymap-drawer/keyball44.svg" >
