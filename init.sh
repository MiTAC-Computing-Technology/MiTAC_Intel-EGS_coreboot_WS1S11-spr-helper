#!/bin/bash

ROOT_DIR=$(pwd)
COREBOOT_SRC_DIR=${ROOT_DIR}/coreboot
COREBOOT_PATCH_DIR=${ROOT_DIR}/patches

export BUILD_TIME=`date +%y%m%d`

START_TIME=`date +%s`

function setup_env()
{
    echo
    echo "============================================"
    echo "         Setup coreboot Environment         "
    echo "============================================"
    echo

    # Install Ubuntu 22.04.2 necessary packages
    sudo apt-get update
    sudo apt-get install -y build-essential iasl uuid-dev nasm openssl gcc-multilib qemu-kvm git libelf-dev libncurses-dev libssl-dev pkg-config m4 bison flex libnss3-dev imagemagick python2 curl make bc

    # Create python2 link for coverity container
    sudo ln -s /usr/bin/python2 /usr/bin/python
}

function download_coreboot()
{
    echo
    echo "============================================"
    echo "         Download coreboot source           "
    echo "============================================"
    echo

    if [ -d $COREBOOT_SRC_DIR ]; then
        rm -rf $COREBOOT_SRC_DIR
    else
        git clone https://github.com/coreboot/coreboot.git coreboot
        git -C coreboot checkout --quiet dfef1895f2fb743b1e19258d520aa279542984e4
    fi
}

function update_patches()
{
    if [ -d $COREBOOT_SRC_DIR ]; then

        echo
        echo "============================================"
        echo "         Apply WS-2 coreboot Patches        "
        echo "============================================"
        echo

        cd ${COREBOOT_SRC_DIR}
        git am ${COREBOOT_PATCH_DIR}/*.patch
    fi
}

function build_crossgcc()
{
    echo
    echo "============================================"
    echo "          Build Cross GCC Compiler          "
    echo "============================================"
    echo

    if [ ! -d $COREBOOT_DIR/util/crossgcc/xgcc ]; then
        make crossgcc-i386 CPUS=$(nproc) BUILD_LANGUAGES=c
    fi
}

# Setup build environment
setup_env

# Download coreboot
download_coreboot

# Update patches
update_patches

# Build crossgcc
build_crossgcc

END_TIME=`date +%s`
let "ELAPSED_TIME=$END_TIME-$START_TIME"
echo "Total compile time is $ELAPSED_TIME seconds"

echo ok success !!!
