OUTPUT_FORMAT(elf64-x86-64)
OUTPUT_ARCH(i386:x86-64)

ENTRY(_start)

/*
FLAGS
-----
READ        - (1 << 2)
WRITE       - (1 << 1)
EXECUTION   - (1 << 0)
*/

PHDRS
{
    text    PT_LOAD FLAGS((1 << 0) | (1 << 2)); 
    rodata  PT_LOAD FLAGS((1 << 2)); 
    data    PT_LOAD FLAGS((1 << 1) | (1 << 2));
}

SECTIONS
{
    . = 0xffffffff80000000;

    KERNEL_START = .;

    .text : {
        *(.text .text.*)
    } :text

    . += CONSTANT(MAXPAGESIZE);

    .data : {
        *(.data .data.*)
    } :data

    .bss : {
        *(COMMON)
        *(.bss .bss.*)
    } :data

    /DISCARD/ : {
        *(.note .note.*)
    }

    KERNEL_END = .;
}

/*
[0x1e39607d] <panic+0x9d>
[0x1e39286e] <elf64_load+0x6fe>
[0x1e3abbc0] <limine_load+0x230>
[0x1e3a93f9] <boot+0x89>
[0x1e3a8e66] <_menu+0x1306>
*/