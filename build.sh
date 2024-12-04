#!/bin/bash

ROOT_DIR=$(pwd)
COREBOOT_DIR=${ROOT_DIR}/coreboot

export BUILD_TIME=`date +%y%m%d`

START_TIME=`date +%s`

function build_ws_2()
{
    echo
    echo "============================================"
    echo "          Build WS-2 coreboot Image         "
    echo "============================================"
    echo

    cd ${COREBOOT_DIR}
    make distclean
    make defconfig KBUILD_DEFCONFIG=configs/config.mitaccomputing_ws_2

    # Build coreboot.rom
    make -j$(nproc --ignore=1)
    cd -
}

# Build coreboot image
build_ws_2

END_TIME=`date +%s`
let "ELAPSED_TIME=$END_TIME-$START_TIME"
echo "Total compile time is $ELAPSED_TIME seconds"

echo ok success !!!
