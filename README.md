# WS1S11-spr-helper

1. This is source code setup repository for MiTAC WS1S11 of Intel EGS with SPR CPU.
2. Supported platform: MiTAC WS1S11, the system supports single processor for 5G infra which is using Intel EGS_SPR platform
   ( https://www.mitaccomputing.com/5GEdgeComputing_WS1S11_WS1S11_EN~Spec )


## Clone Repositories

1. Execute ./init.sh to clone source codes, apply patches and setup build environment


## Prepare necessary binary files

1. Download the latest Fsp files (https://github.com/intel/FSP.git)
2. Split Fsp.fd to Fsp_M.fd, Fsp_S.fd and Fsp_T.fd files
3. Copy FspmUpd.h, FspsUpd.h, FsptUpd.h and FspUpd.h to vendorcode/intel/fsp/fsp2_0/sapphirerapids_sp
4. Copy Fsp_M.fd, Fsp_S.fd and Fsp_T.fd to coreboot/site-local/whitestone-2
5. Copy descriptor.bin, me.bin and gbe.bin to coreboot/site-local/whitestone-2
P.S. If you have any question, please feel free to contact MiTAC Computing Technology Corporation, MCT.


## Build and Deploy

1. Execute ./build.sh to build debug rom
2. Deploy coreboot.rom to 64MB SPI flash of WS1S11


## Progress

- With these repositories, WS1S11 + EagleStream can boot to LinuxBoot successfully
- Debug messages are available through FCH MMIO
- Only verify in Linux build environment


## Reference

