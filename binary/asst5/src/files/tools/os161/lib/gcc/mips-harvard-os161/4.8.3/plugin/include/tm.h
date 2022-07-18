#ifndef GCC_TM_H
#define GCC_TM_H
#define TARGET_CPU_DEFAULT (((MASK_ABICALLS|MASK_SPLIT_ADDRESSES))|MASK_EXPLICIT_RELOCS)
#ifndef LIBC_GLIBC
# define LIBC_GLIBC 1
#endif
#ifndef LIBC_UCLIBC
# define LIBC_UCLIBC 2
#endif
#ifndef LIBC_BIONIC
# define LIBC_BIONIC 3
#endif
#ifdef IN_GCC
# include "options.h"
# include "insn-constants.h"
# include "config/elfos.h"
# include "config/vxworks-dummy.h"
# include "config/mips/mips.h"
# include "config/mips/elf.h"
# include "config/os161.h"
# include "config/os161-elf.h"
# include "config/mips/os161.h"
# include "config/initfini-array.h"
#endif
#if defined IN_GCC && !defined GENERATOR_FILE && !defined USED_FOR_TARGET
# include "insn-flags.h"
#endif
# include "defaults.h"
#endif /* GCC_TM_H */
