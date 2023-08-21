#
#	Project specific
#

## Project name, also the name of image files

PROJECT		= proj_aes
# See platform.mk
MCU			= stm32f103_8

## Add source files, these will be compiled to .o modules one by one
# main.c must exist as the main module
CFILES		= main.c
CFILES		+= api.c

#AFILES		= mod.S

#CXXFILES	= mod.cpp

LDFILE		= linker.ld

## Define macros

#DEFS		= -DDEBUG

## C standard and optimization

CSTD		= -std=c99
CXXSTD		= -std=c++11

OPT			= -Os
#OPT		= -Og

## Debug
# Default, enable debug support
D			= 1
ifeq (${D},1)
DEBUG		= -g
endif

#
#	Debugger settings
#

## ST-Link settings
# Flash base address
STFLASH_ADDR		= 0x8000000
# Amount of st-flash.read data
STFLASH_LEN			= 1024
# File st-flash.read dumps to
STFLASH_DUMP		= ${FLASH_DIR}/read.bin
# Port number of st-util.gdb
STLINK_GDB_PORT		= 4242

## OpenOCD config file

#OOCD_FILE			= ${SCRIPT_DIR}/myocd.cfg

## If no OpenOCD config file, specify INTERFACE. TARGET has been inferenced

#OOCD_INTERFACE		= cmsis-dap
#OOCD_INTERFACE		= jlink
OOCD_INTERFACE		= stlink
#OOCD_INTERFACE		= ti-icdi
#OOCD_INTERFACE		= ulink
#OOCD_INTERFACE		= ftdi/oocdlink
#OOCD_INTERFACE		= usb-jtag
#OOCD_INTERFACE		= openjtag
#OOCD_INTERFACE		= nulink

## Black Magic Probe settings

BMP_PORT			?= /dev/ttyACM0

#
#	General make rules
#

include platform.mk
include rules.mk