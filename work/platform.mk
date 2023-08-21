#
#	Common MCUs
#	Add new MCU as you like
#
#	PLATFORMs supported by libopencm3:
#	1. ST: stm32f0 stm32f1 stm32f2 stm32f3 stm32f4 stm32f7
#	stm32l0 stm32l1 stm32l4 stm32g0 stm32g4 stm32h7
#	2. Atmel: sam3a sam3n sam3s sam3u sam3x sam4l
#	3. NXP: lpc13xx lpc17xx lpc43xx lpc43xx_m0
#	4. Nordic: nrf51 nrf52
#	5. TI: msp432e4 lm3s lm4f
#	6. GigaDevice: gd32f1x0
#
#	SRAMSIZE and FLASHSIZE are only for later reference 
#	if required
#	SRAMSIZE is total SRAM size which could be composed of
#	asymmetric parts
#

ifeq (${MCU},stm32f103_6)
OOCD_TARGET			= stm32f1x
PLATFORM			= stm32f1
FLASHSIZE			= 32k
#SRAMSIZE			= 10k
STFLASH_FLASHSIZE	= ${FLASHSIZE}
else ifeq (${MCU},stm32f103_8)
OOCD_TARGET			= stm32f1x
PLATFORM			= stm32f1
FLASHSIZE			= 64k
#SRAMSIZE			= 20k
STFLASH_FLASHSIZE	= ${FLASHSIZE}
else ifeq (${MCU},stm32f103_b)
OOCD_TARGET			= stm32f1x
PLATFORM			= stm32f1
FLASHSIZE			= 128k
#SRAMSIZE			= 20k
STFLASH_FLASHSIZE	= ${FLASHSIZE}
else ifeq (${MCU},stm32g070_b)
OOCD_TARGET			= stm32g0x
PLATFORM			= stm32g0
FLASHSIZE			= 128k
#SRAMSIZE			= 36k
STFLASH_FLASHSIZE	= ${FLASHSIZE}
else ifeq (${MCU},stm32f401_c)
OOCD_TARGET			= stm32f4x
PLATFORM			= stm32f4
FLASHSIZE			= 256k
#SRAMSIZE			= 64k
STFLASH_FLASHSIZE	= ${FLASHSIZE}
else ifeq (${MCU},stm32f402_c)
OOCD_TARGET			= stm32f4x
PLATFORM			= stm32f4
FLASHSIZE			= 256k
#SRAMSIZE			= 64k
STFLASH_FLASHSIZE	= ${FLASHSIZE}
else ifeq (${MCU},stm32f411_e)
OOCD_TARGET			= stm32f4x
PLATFORM			= stm32f4
FLASHSIZE			= 512k
#SRAMSIZE			= 128k
STFLASH_FLASHSIZE	= ${FLASHSIZE}
else ifeq (${MCU},stm32f412_e)
OOCD_TARGET			= stm32f4x
PLATFORM			= stm32f4
FLASHSIZE			= 512k
#SRAMSIZE			= 256k
STFLASH_FLASHSIZE	= ${FLASHSIZE}
else ifeq (${MCU},stm32l431_c)
OOCD_TARGET			= stm32f4x
PLATFORM			= stm32f4
FLASHSIZE			= 256k
#SRAMSIZE			= 64k
STFLASH_FLASHSIZE	= ${FLASHSIZE}
else ifeq (${MCU},stm32f746_g)
OOCD_TARGET			= stm32f7x
PLATFORM			= stm32f7
FLASHSIZE			= 1M
#SRAMSIZE			= 320k
STFLASH_FLASHSIZE	= ${FLASHSIZE}
else ifeq (${MCU},atsam3s4)
OOCD_TARGET			= at91sam3sXX
PLATFORM			= sam3s
FLASHSIZE			= 256k
#SRAMSIZE			= 48k
else ifeq (${MCU},atsam3x8)
OOCD_TARGET			= at91sam3XXX
PLATFORM			= sam3x
FLASHSIZE			= 512k
#SRAMSIZE			= 96k
else ifeq (${MCU},lpc4320_m4)		# Flashless, M4 part
OOCD_TARGET			= lpc4350
PLATFORM			= lpc43xx
FLASHSIZE			= 0
#SRAMSIZE			= 200k
else ifeq (${MCU},lpc4320_m0)		# Flashless, M0 part
OOCD_TARGET			= lpc4350
PLATFORM			= lpc43xx_m0
FLASHSIZE			= 0
#SRAMSIZE			= 200k
endif

#
#	libopencm3 platform specific settings, do not modify
#	You can overwrite MCPU when invoking make if necessary
#

LIBNAME		= opencm3_${PLATFORM}
ARCH_FLAGS	= -mthumb

ifeq (${PLATFORM},stm32f0)
DEFS		+= -DSTM32F0
MCPU		= cortex-m0
else ifeq (${PLATFORM},stm32f1)
DEFS		+= -DSTM32F1
MCPU		= cortex-m3
else ifeq (${PLATFORM},stm32f2)
DEFS		+= -DSTM32F2
MCPU		= cortex-m3
else ifeq (${PLATFORM},stm32f3)
DEFS		+= -DSTM32F3
MCPU		= cortex-m4f-hard
else ifeq (${PLATFORM},stm32f4)
DEFS		+= -DSTM32F4
MCPU		= cortex-m4f-hard
else ifeq (${PLATFORM},stm32f7)
DEFS		+= -DSTM32F7
MCPU		= cortex-m7-hard
else ifeq (${PLATFORM},stm32l0)
DEFS		+= -DSTM32L0
MCPU		= cortex-m0+
else ifeq (${PLATFORM},stm32l1)
DEFS		+= -DSTM32L1
MCPU		= cortex-m3
else ifeq (${PLATFORM},stm32l4)
DEFS		+= -DSTM32L4
MCPU		= cortex-m4f-hard
else ifeq (${PLATFORM},stm32g0)
DEFS		+= -DSTM32G0
MCPU		= cortex-m0+
else ifeq (${PLATFORM},stm32g4)
DEFS		+= -DSTM32G4
MCPU		= cortex-m4f-hard
else ifeq (${PLATFORM},stm32h7)
DEFS		+= -DSTM32H7
MCPU		= cortex-m7-hard
else ifeq (${PLATFORM},gd32f1x0)
DEFS		+= -DGD32F1X0
MCPU		= cortex-m3
else ifeq (${PLATFORM},lpc13xx)
DEFS		+= -DLPC13XX
MCPU		= cortex-m3
else ifeq (${PLATFORM},lpc17xx)
DEFS		+= -DLPC17XX
MCPU		= cortex-m3
else ifeq (${PLATFORM},lpc43xx)
DEFS		+= -DLPC43XX
MCPU		= cortex-m4f-hard
else ifeq (${PLATFORM},lpc43xx_m0)
DEFS		+= -DLPC43XX_M0
MCPU		= cortex-m0
else ifeq (${PLATFORM},msp432e4)
DEFS		+= -DMSP432E4
MCPU		= cortex-m4f-hard
else ifeq (${PLATFORM},lm3s)
DEFS		+= -DLM3S
MCPU		= cortex-m3
else ifeq (${PLATFORM},lm4f)
DEFS		+= -DLM4F
MCPU		= cortex-m4f-hard
else ifeq (${PLATFORM},nrf51)
DEFS		+= -DNRF51
MCPU		= cortex-m0
else ifeq (${PLATFORM},nrf52)
DEFS		+= -DNRF52
MCPU		= cortex-m4f-hard
else ifeq (${PLATFORM},sam3a)
DEFS		+= -DSAM3A
MCPU		= cortex-m3
else ifeq (${PLATFORM},sam3n)
DEFS		+= -DSAM3N
MCPU		= cortex-m3
else ifeq (${PLATFORM},sam3s)
DEFS		+= -DSAM3S
MCPU		= cortex-m3
else ifeq (${PLATFORM},sam3x)
DEFS		+= -DSAM3X
MCPU		= cortex-m3
else ifeq (${PLATFORM},sam4l)
DEFS		+= -DSAM4L
MCPU		= cortex-m4f-hard
endif

#
#	ARMv7-M cpus. Do not modify
#

ifeq (${MCPU},cortex-m0)
ARCH_FLAGS	+= -mcpu=cortex-m0
ARCH_FLAGS	+= -mfloat-abi=soft
else ifeq (${MCPU},cortex-m0+)
ARCH_FLAGS	+= -mcpu=cortex-m0plus
ARCH_FLAGS	+= -mfloat-abi=soft
else ifeq (${MCPU},cortex-m3)
ARCH_FLAGS	+= -mcpu=cortex-m3
ARCH_FLAGS	+= -mfloat-abi=soft
ARCH_FLAGS	+= -mfix-cortex-m3-ldrd
else ifeq (${MCPU},cortex-m4-soft)		# Pure softfloat, no hardfloat support
ARCH_FLAGS	+= -mcpu=cortex-m4
ARCH_FLAGS	+= -mfloat-abi=soft
else ifeq (${MCPU},cortex-m4f-softfp)	# Use VFP instructions, compatible with softfloat abi
ARCH_FLAGS	+= -mcpu=cortex-m4
ARCH_FLAGS	+= -mfloat-abi=softfp
ARCH_FLAGS	+= -mfpu=fpv4-sp-d16
else ifeq (${MCPU},cortex-m4f-hard)		# Hardfloat abi. Not compatible with softfloat abi
ARCH_FLAGS	+= -mcpu=cortex-m4
ARCH_FLAGS	+= -mfloat-abi=hard
ARCH_FLAGS	+= -mfpu=fpv4-sp-d16
else ifeq (${MCPU},cortex-m7-soft)		# Softfloat
ARCH_FLAGS	+= -mcpu=cortex-m7
ARCH_FLAGS	+= -mfloat-abi=soft
else ifeq (${MCPU},cortex-m7-softfp)	# Use VFP instructions 
ARCH_FLAGS	+= -mcpu=cortex-m7
ARCH_FLAGS	+= -mfloat-abi=softfp
ARCH_FLAGS	+= -mfpu=fpv5-sp-d16
else ifeq (${MCPU},cortex-m7-softfp-dp)	# Enable VFP double precision
ARCH_FLAGS	+= -mcpu=cortex-m7
ARCH_FLAGS	+= -mfloat-abi=softfp
ARCH_FLAGS	+= -mfpu=fpv5-d16
else ifeq (${MCPU},cortex-m7-hard)		# Hardfloat
ARCH_FLAGS	+= -mcpu=cortex-m7
ARCH_FLAGS	+= -mfloat-abi=hard
ARCH_FLAGS	+= -mfpu=fpv5-sp-d16
else ifeq (${MCPU},cortex-m7-hard-dp)	# Hardfloat with double precision
ARCH_FLAGS	+= -mcpu=cortex-m7
ARCH_FLAGS	+= -mfloat-abi=hard
ARCH_FLAGS	+= -mfpu=fpv5-d16
endif