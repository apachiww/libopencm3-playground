/**
 *  Define memory regions.
 */

MEMORY
{
	rom (rx) : ORIGIN = 0x08000000, LENGTH = 64K
	ram (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}

/**
 *  Include the common ld script.
 *
 *  Linker will search for this file in
 *  library directories specified by -L
 *
 *  See cortex-m-generic-copy.ld in the same
 *  directory for a reference, modify it
 *	and INCLUDE it if you want customized 
 *	layouts
 */

INCLUDE cortex-m-generic.ld