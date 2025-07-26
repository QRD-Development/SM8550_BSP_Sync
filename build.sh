#!/usr/bin/env bash

BUILD_ROOT="$PWD"

QSSI_DIR="${BUILD_ROOT}/qssi"
VENDOR_DIR="${BUILD_ROOT}/vendor"
LE_DIR="${BUILD_ROOT}/le"
KERNEL_PLATFORM="${VENDOR_DIR}/kernel_platform"

function build_target {
    cd "$VENDOR_DIR"
    source build/envsetup.sh
    lunch kalama-userdebug
    RECOMPILE_KERNEL=1 kernel_platform/build/android/prepare_vendor.sh kalama gki
    ./build.sh dist --target_only -j "$(nproc --all)"
}

function build_qssi {
    cd "$QSSI_DIR"
    source build/envsetup.sh
    lunch qssi-userdebug
    ./build.sh dist --qssi_only -j "$(nproc --all)"
}

function build_super {
    cd "$VENDOR_DIR"

    python vendor/qcom/opensource/core-utils/build/build_image_standalone.py \
        --image super \
        --qssi_build_path "$QSSI_DIR" \
        --target_build_path "$VENDOR_DIR" \
        --merged_build_path "$VENDOR_DIR" \
        --target_lunch kalama \
        --no_tmp \
        --output_ota \
        --skip_qiifa
}

function build_kernel {
    cd "$VENDOR_DIR"
    bash kernel_platform/qcom/proprietary/prebuilt_HY11/vendorsetup.sh
    cd "$KERNEL_PLATFORM"
    BUILD_CONFIG=./common/build.config.msm.kalama ./build/all-variants.sh "./build/build.sh" |& tee kernel_makelog_$(date +%Y%m%d_%H%M%S).txt
    cd "$VENDOR_DIR"
    cp -r "$KERNEL_PLATFORM"/out/* "$VENDOR_DIR"/out/
}

function build_le {
    cd "$KERNEL_PLATFORM" && BUILD_CONFIG=msm-kernel/build.config.msm.kalama.tuivm VARIANT=debug_defconfig ./build/build.sh
    mkdir -p "$LE_DIR"/src/kernel-5.15/
    cp -rp "$VENDOR_DIR"/kernel_platform "$LE_DIR"/src/kernel-5.15/
    cp -rp "$VENDOR_DIR"/kernel_platform/out/ "$LE_DIR"/src/kernel-5.15/
    cd "$BUILD_ROOT"
    mkdir DisplaySI && cd DisplaySI
    repo init --depth=1 -q -u https://git.codelinaro.org/clo/la/techpack/display/manifest.git -b release -m AU_TECHPACK_DISPLAY.LA.3.0.R1.00.00.00.000.134.xml
    repo sync -q -c --force-sync --optimized-fetch --no-tags --retry-fetches=5 -j"$(nproc --all)"
    /bin/cp -rf "$BUILD_ROOT"/snapdragon-premium-high-2022-spf-2-0-2_amss_standard_oem-r2.0.2.r1_00002.0/DISPLAY.LA.3.0/LINUX/android/vendor/qcom/proprietary ./vendor/qcom/
    cp -rp "$BUILD_ROOT"/DisplaySI/* "$LE_DIR"/src/display/
    cd "$LE_DIR"
    export SHELL=/bin/bash
    export MACHINE=trustedvm
    export DISTRO=qti-distro-base-debug
    source poky/qti-conf/set_bb_env.sh
    bitbake qti-vm-image
}

build_qssi
build_kernel
build_target
build_super
build_le
