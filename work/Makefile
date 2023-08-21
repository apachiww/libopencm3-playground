#
#	Project specific
#

## Project name, also the name of image files

PROJECT		= proj_aes
MCU			= stm32f103_6	# See platform.mk

## Add source files, these will be compiled to .o modules one by one

CFILES		= main.c	# main.c must exist as the main module
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

D			= 1		# Default, enable debug support
ifeq (${D},1)
DEBUG		= -ggdb3
endif

#
#	Debugger settings
#

## ST-Link settings
STFLASH_ADDR		= 0x8000000				# Flash base address
STFLASH_LEN			= 1024						# Amount of st-flash.read data
STFLASH_DUMP		= ${FLASH_DIR}/read.bin	# File st-flash.read dumps to
STLINK_GDB_PORT		= 4242						# Port number of st-util.gdb

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