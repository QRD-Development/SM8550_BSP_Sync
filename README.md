# Qualcomm Products Board Support Package (BSP) HLOS Sync scripts

## Why was these scripts created?
1. These scripts was created to automate the process of syncing the Qualcomm Products Board Support Package (BSP) sources.
2. Qualcomm had released the "Release Note" for every Software Product (SP), but sometimes it's hard to find the correct sources or hard to use for the SP.
3. These scripts helps to sync the Qualcomm Products BSP sources easily.

## How to use?
1. Clone this repository
2. Run the scripts with the following command

#### Sync all Sources (QSSI Open Source parts & Vendor Open Source parts & Linux Embedded (LE) Open Source parts)
```bash
$ bash setup.sh && bash sync.sh
```

#### Sync Qualcomm private code (QSSI & Vendor Closed Source parts)
###### Note: You need to have access to the Qualcomm ChipCode website to download the private code.
- Download the Qualcomm private code from the Qualcomm ChipCode Website or use Git to clone the private code repository.
- For example, the QCM6490 BSP private code is located at `https://chipcode.qti.qualcomm.com/qualcomm/qcm6490-la-3-0_ap_standard_oem`
- So clone the private code repository using the following command
```bash
$ git clone -b r00082.2 --depth 1 https://qpm-git.qualcomm.com/home2/git/qualcomm/qcm6490-la-3-0_ap_standard_oem.git
```
- Notes: 
  1. The `r00082.2` is the tag name of the private code. You can use the latest tag name.
  2. The `--depth 1` is used to clone the latest commit only. You can remove it to clone the full repository.
  3. Don't place the private code directory inside the OpenSources repository directory. Keep it separate.
- Copy the private code to the `vendor/qcom/proprietary` directory.

```bash
cd qssi/
mkdir -p vendor/qcom/proprietary
cd vendor/qcom/proprietary
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/LA.QSSI.15.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
```

```bash
cd vendor/
mkdir -p vendor/qcom/proprietary
cd vendor/qcom/proprietary
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/LA.QSSI.13.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/AUDIO.LA.8.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/DISPLAY.LA.3.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/VIDEO.LA.3.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/XR.LA.1.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/CV.LA.1.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/SENSORS.LA.3.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/GRAPHICS.LA.1.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/CAMERA.LA.3.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/LA.VENDOR.13.2.0/LINUX/android/vendor/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
```

```bash
cd vendor/kernel_platform/
mkdir -p qcom/proprietary
cd qcom/proprietary
/bin/cp -rf /mnt/SX8200Pro/SM8550_BSP/snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/KERNEL.PLATFORM.2.0/kernel_platform/qcom/proprietary/* ./
git add . && git commit -s -m "$(head -n 1 prebuilt_HY11/AU_INFO.txt)"
```

```bash
cd kernel_platform &&
BUILD_CONFIG=msm-kernel/build.config.msm.kalama.tuivm VARIANT=debug_defconfig ./build/build.sh
mkdir -p <LE workpace path>/src/kernel-5.15/
cp -rp <kernel SI workspace path>/kernel_platform <LE workpace path>/src/kernel-5.15/
cp -rp <kernel SI workspace path>/kernel_platform/out/ <LE workpace path>/src/kernel-5.15/
```

```bash
mkdir DisplaySI
cd DisplaySI
repo init --depth=1 -q -u https://git.codelinaro.org/clo/la/techpack/display/manifest.git -b release -m AU_TECHPACK_DISPLAY.LA.3.0.R1.00.00.00.000.127.xml
repo sync -q -c --force-sync --optimized-fetch --no-tags --retry-fetches=5 -j"$(nproc --all)"
/bin/cp -rf ../snapdragon-premium-high-2022-spf-2-0-1_amss_standard_oem-r2.0.1/DISPLAY.LA.3.0/LINUX/android/vendor/qcom/proprietary ./vendor/qcom/
cp -rp <Display SI>/* <LE workpace path>/src/display/
```

## Reference
- [SM8550 BSP Compile Guide](https://hackmd.io/@EdwardWu/Kalama_BSP_CompileGuide)

#### Build/Compile kalama HLOS
```bash
$ bash build.sh
```

## License
These scripts is licensed under the GPL-3.0 License. See the [LICENSE](LICENSE) file for details.

## Credits
- [Qualcomm Technologies, Inc.](https://www.qualcomm.com/)
- [Qualcomm Chipcode](https://chipcode.qti.qualcomm.com)
- [CodeLinaro](https://git.codelinaro.org/)
- [Jyotiraditya](https://github.com/imjyotiraditya)
- [EdwardWu](https://github.com/bluehomewu)
- [QRD-Development](https://github.com/QRD-Development)




