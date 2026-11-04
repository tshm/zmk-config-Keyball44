CONFIG_FILES := $(shell find config -type f)
IMG := zmkfirmware/zmk-build-arm:stable
PODMAN := podman run --rm --userns=keep-id -v "$(CURDIR):/workspace:Z" -w /workspace $(IMG)
BUILD := $(PODMAN) west build -p always -s zmk/app -b nice_nano_v2

.PHONY: all west-update
all: ./build/firmware_right.uf2 ./build/firmware_left.uf2 ./build/settings_reset.uf2

.west/config:
	$(PODMAN) west init -l config

west-update: .west/config
	$(PODMAN) west update
	touch .west/manifest-updated

.west/manifest-updated: config/west.yml .west/config
	$(PODMAN) west update
	touch $@

./build/firmware_left.uf2: .west/manifest-updated $(CONFIG_FILES) Makefile
	$(BUILD) -d build/left -- -DZephyr_DIR=/workspace/zephyr/share/zephyr-package/cmake -DZMK_CONFIG=/workspace/config -DZMK_EXTRA_MODULES=/workspace/config/keyboard -DSHIELD=keyball44_left
	mv build/left/zephyr/zmk.uf2 $@

./build/firmware_right.uf2: .west/manifest-updated $(CONFIG_FILES) Makefile
	$(BUILD) -d build/right -S studio-rpc-usb-uart -- -DZephyr_DIR=/workspace/zephyr/share/zephyr-package/cmake -DZMK_CONFIG=/workspace/config -DZMK_EXTRA_MODULES=/workspace/config/keyboard -DSHIELD=keyball44_right -DCONFIG_ZMK_STUDIO=y
	mv build/right/zephyr/zmk.uf2 $@

./build/settings_reset.uf2: .west/manifest-updated $(CONFIG_FILES) Makefile
	$(BUILD) -d build/settings_reset -- -DZephyr_DIR=/workspace/zephyr/share/zephyr-package/cmake -DZMK_CONFIG=/workspace/config -DZMK_EXTRA_MODULES=/workspace/config/keyboard -DSHIELD=settings_reset
	mv build/settings_reset/zephyr/zmk.uf2 $@
