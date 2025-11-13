all: .west/config ./build/firmware_right.uf2 ./build/firmware_left.uf2

img:=zmkfirmware/zmk-build-arm:stable
setup_cmd:=podman run --rm -e KCONFIG_WARN_TO_ERROR=0 -v ${PWD}:/workspace -w /workspace ${img}
build_cmd:=${setup_cmd} west build -s zmk/app -b nice_nano_v2

.west/config:
	${setup_cmd} west init -l config
	${setup_cmd} west update

./build/firmware_%.uf2: ./config/*
	${build_cmd} -d build/$* -- -DZephyr_DIR=/workspace/zephyr/share/zephyr-package/cmake -DZMK_CONFIG=/workspace/config -DSHIELD=keyball44_$*
	mv ./build/$*/zephyr/zmk.uf2 $@

