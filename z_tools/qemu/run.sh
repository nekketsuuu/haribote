#!/bin/sh

# I use QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.4) on Ubuntu 18.04 LTS Bionic
#
# Changes from the original
#
# * SDL_VIDEODRIVER: windib --> x11
# * --localtime --> -rtc base=localtime (--localtime is deprecated)
# * Remove -std-vga, which is an option for Windows XP
# * Change `-fda` option to `-drive` option in order to delete a warning

export SDL_VIDEODRIVER=x11
export QEMU_AUDIO_DRV=none
export QEMU_AUDIO_LOG_TO_MONITOR=0
qemu-system-i386 -L . -m 32 -rtc base=localtime -drive file=fdimage0.bin,format=raw,index=0,if=floppy
