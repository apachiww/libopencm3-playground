#
#	Constant variables
#

## Toolchain commands

PREFIX		= arm-none-eabi-
CC			= ${PREFIX}gcc
CXX			= ${PREFIX}g++
CPP			= ${PREFIX}cpp
LD			= ${PREFIX}ld
AR			= ${PREFIX}ar
AS			= ${PREFIX}as
OBJCOPY		= ${PREFIX}objcopy
OBJDUMP		= ${PREFIX}objdump
SIZE		= ${PREFIX}size

## Directories

OPENCM3_DIR	= ../libopencm3
OPENCM3_INC	= ${OPENCM3_DIR}/include
OPENCM3_LIB	= ${OPENCM3_DIR}/lib
BUILD_DIR	= _build
FLASH_DIR	= _flash
SCRIPT_DIR	= scripts
USER_INC	= inc
USER_SRC	= src
USER_LD		= ld

## All .o objects and ld script

OBJS		= ${CFILES:%.c=${BUILD_DIR}/%.o}
OBJS		+= ${AFILES:%.S=${BUILD_DIR}/%.o}
OBJS		+= ${CXXFILES:%.cpp=${BUILD_DIR}/%.o}
LDSCRIPT	= ${USER_LD}/${LDFILE}

## C flags

TGT_CFLAGS		= ${OPT}
TGT_CFLAGS		+= ${DEBUG}
TGT_CFLAGS		+= ${ARCH_FLAGS}
TGT_CFLAGS		+= ${CSTD}
TGT_CFLAGS		+= -Wall
TGT_CFLAGS		+= -fno-common
TGT_CFLAGS		+= -ffunction-sections
TGT_CFLAGS		+= -fdata-sections

#CFLAGS			=

## C++ flags

TGT_CXXFLAGS	= ${OPT}
TGT_CXXFLAGS	+= ${DEBUG}
TGT_CXXFLAGS	+= ${ARCH_FLAGS}
TGT_CXXFLAGS	+= ${CXXSTD}
TGT_CXXFLAGS	+= -Wall
TGT_CXXFLAGS	+= -fno-common
TGT_CXXFLAGS	+= -ffunction-sections
TGT_CXXFLAGS	+= -fdata-sections

#CXXFLAGS		=

## CPP flags, add .h header file search paths 
# Generate .d dependencies in the same directory
TGT_CPPFLAGS	= -MD
TGT_CPPFLAGS	+= -Wall
TGT_CPPFLAGS	+= -I${OPENCM3_INC}
TGT_CPPFLAGS	+= -iquote${USER_INC}
TGT_CPPFLAGS	+= ${DEFS}

#CPPFLAGS		=

## AS flags

TGT_ASFLAGS		= ${DEBUG}
TGT_ASFLAGS		+= ${OPT}
TGT_ASFLAGS		+= ${ARCH_FLAGS}

#ASFLAGS		=

## LD flags, add .a library file search path and library name

TGT_LDFLAGS		= ${DEBUG}
TGT_LDFLAGS		+= --static
TGT_LDFLAGS		+= -nostartfiles
TGT_LDFLAGS		+= -T${LDSCRIPT}
TGT_LDFLAGS		+= ${ARCH_FLAGS}
TGT_LDFLAGS		+= -Wl,--gc-sections
TGT_LDFLAGS		+= -Wl,--cref
TGT_LDFLAGS		+= -Wl,--start-group
TGT_LDFLAGS		+= -Wl,--end-group
TGT_LDFLAGS		+= -lc
TGT_LDFLAGS		+= -lgcc
TGT_LDFLAGS		+= -lnosys
TGT_LDFLAGS		+= -specs=nano.specs
TGT_LDFLAGS		+= -L${OPENCM3_LIB}
TGT_LDFLAGS		+= -l${LIBNAME}

#LDFLAGS		=

#
#	Make all
#

all: bin hex list
bin: ${FLASH_DIR}/${PROJECT}.bin
hex: ${FLASH_DIR}/${PROJECT}.hex
srec: ${FLASH_DIR}/${PROJECT}.srec
list: ${FLASH_DIR}/${PROJECT}.list
lss: ${FLASH_DIR}/${PROJECT}.lss

#
#	If library does not exist, create it
#

${OPENCM3_DIR}/lib/lib${LIBNAME}.a:
ifeq (${wildcard $@},)
	@echo "  INFO lib${LIBNAME}.a not found, rebuild libopemcm3"
	@make -j6 -C ${OPENCM3_DIR}
endif

#
#	Create directories for output if not exist, order-only
#

${BUILD_DIR}:
	@mkdir -p ${BUILD_DIR}

${FLASH_DIR}:
	@mkdir -p ${FLASH_DIR}

#
#	File rules
#

## C source to object, with .d dependency generated and included at end of Makefile

${BUILD_DIR}/%.o: ${USER_SRC}/%.c | ${BUILD_DIR}
	@printf "  CC\t$<\t->\t$@\n"
	@${CC} ${TGT_CFLAGS} ${CFLAGS} ${TGT_CPPFLAGS} ${CPPFLAGS} -c $< -o $@

## C++ source to object with .d

${BUILD_DIR}/%.o: ${USER_SRC}/%.cpp | ${BUILD_DIR}
	@printf "  CXX\t$<\t->\t$@\n"
	@${CXX} ${TGT_CXXFLAGS} ${CXXFLAGS} ${TGT_CPPFLAGS} ${CPPFLAGS} -c $< -o $@

## Assembly source to object with .d

${BUILD_DIR}/%.o: ${USER_SRC}/%.S | ${BUILD_DIR}
	@printf "  AS\t$<\t->\t$@\n"
	@${CC} ${TGT_ASFLAGS} ${ASFLAGS} ${TGT_CPPFLAGS} ${CPPFLAGS} -c $< -o $@

## The only .elf file, with .map generated. Take care of .o object file and -llibrary order!

${BUILD_DIR}/${PROJECT}.elf ${BUILD_DIR}/${PROJECT}.map: ${OBJS} ${OPENCM3_DIR}/lib/lib${LIBNAME}.a ${LDSCRIPT}
	@printf "  LD\t${BUILD_DIR}/${PROJECT}.elf\n"
	@${CC} ${OBJS} ${TGT_LDFLAGS} ${LDFLAGS} -Wl,-Map=${BUILD_DIR}/${PROJECT}.map -o ${BUILD_DIR}/${PROJECT}.elf

#
#	Output program images, only one file
#

${FLASH_DIR}/%.bin: ${BUILD_DIR}/%.elf | ${FLASH_DIR}
	@printf "  BINFILE\t$@\n"
	@${OBJCOPY} -Obinary $< $@

${FLASH_DIR}/%.hex: ${BUILD_DIR}/%.elf | ${FLASH_DIR}
	@printf "  HEXFILE\t$@\n"
	@${OBJCOPY} -Oihex $< $@

${FLASH_DIR}/%.srec: ${BUILD_DIR}/%.elf | ${FLASH_DIR}
	@printf "  SRECFILE\t$@\n"
	@${OBJCOPY} -Osrec $< $@

#
#	Dump elf info
#

${FLASH_DIR}/%.lss: ${BUILD_DIR}/%.elf | ${FLASH_DIR}
	@printf "  DUMPELF\t$@\n"
	@${OBJDUMP} -h -S $< > $@

${FLASH_DIR}/%.list: ${BUILD_DIR}/%.elf | ${FLASH_DIR}
	@printf "  DUMPELF\t$@\n"
	@${OBJDUMP} -S $< > $@

#
#	Common commands
#

clean:
	@printf "  RM ${BUILD_DIR} ${FLASH_DIR}\n"
	@rm -rf ${BUILD_DIR}/* ${FLASH_DIR}/*

#
#	stlink functions
#

st-flash.write.hex: ${FLASH_DIR}/${PROJECT}.hex
	@printf "  ST-FLASH write $<\n"
	@st-flash --reset --flash=${STFLASH_FLASHSIZE} --format ihex write $<

st-flash.write.bin: ${FLASH_DIR}/${PROJECT}.bin
	@printf "  ST-FLASH write $< to ${STFLASH_ADDR}\n"
	@st-flash --reset --flash=${STFLASH_FLASHSIZE} --format binary write $< ${STFLASH_ADDR}

st-flash.read:
	@printf "  ST-FLASH read flash from ${STFLASH_ADDR} size ${STFLASH_LEN}B\n"
	@st-flash --flash=${STFLASH_FLASHSIZE} read ${STFLASH_DUMP} ${STFLASH_ADDR} ${STFLASH_LEN}
	@printf "  ST-FLASH flash dump saved to ${STFLASH_DUMP}\n"

st-info:
	@st-info --probe

st-util.gdb.init:
	@st-util -p ${STLINK_GDB_PORT}
	@printf "  STLINK server started at localhost:${STLINK_GDB_PORT}\n"
	@printf "  TIPS: 1. Connect to server with gdb command 'target extended localhost:${STLINK_GDB_PORT}'\n"
	@printf "        2. Or run 'make st-util.gdb.attach'\n"

st-util.gdb.attach: ${BUILD_DIR}/${PROJECT}.elf
	@printf "  STLINK attach gdb to server at localhost:${STLINK_GDB_PORT}\n"
	@printf "  INFO launching with file $<\n"
	@printf "  TIPS: 1. Run command 'load' to load elf and 'continue' to kick off\n"
	@printf "        2. Run command 'kill' to stop the program and 'run' to start it\n"
	@expect -c "spawn ${GDB} -q $<; expect {\(gdb\) }\
		{send "target extended-remote localhost:${STLINK_GDB_PORT}"}; interact;"

#
#	openocd functions. Not verified
#

ocd.write: ${BUILD_DIR}/${PROJECT}.elf
ifeq ($(OOCD_FILE),)
	@printf "  OPENOCD write $<\n"
	@(echo "halt; program ${realpath $<} verify reset" | nc -4 localhost 4444 2>/dev/null) || \
		openocd -f interface/${OOCD_INTERFACE}.cfg \
		-f target/${OOCD_TARGET}.cfg \
		-c "program $< verify reset exit" \
		2>/dev/null
else
	@printf "  OPENOCD write $<\n"
	@(echo "halt; program ${realpath $<} verify reset" | nc -4 localhost 4444 2>/dev/null) || \
		openocd -f ${OOCD_FILE} \
		-c "program $< verify reset exit" \
		2>/dev/null
endif

#
#	blackmagic functions. Not verified
#	https://github.com/blackmagic-debug/blackmagic
#

bmp.gdb.attach: ${BUILD_DIR}/${PROJECT}.elf
	@printf "  Black Magic gdb\n"
	@${GDB} --batch \
		-ex 'target extended-remote ${BMP_PORT}' \
		-x ${SCRIPT_DIR}/black_magic_probe_flash.scr \
		$<
	
#
#	Makefile end
#

.PHONY: all clean bin hex srec list lss
.PHONY: st-flash.write.hex st-flash.write.bin st-flash.read
.PHONY: st-info st-util.gdb.init st-util.gdb.attach
.PHONY: ocd.write
.PHONY: bmp.gdb.attach
-include ${OBJS:.o=.d}