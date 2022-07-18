#include <types.h>
#include <clock.h>
#include <copyinout.h>
#include <uio.h>
#include <vnode.h>
#include <kern/errno.h>
#include <kern/fcntl.h>
#include <current.h>
#include <vfs.h>
#include <proc.h>

int
sys_getuid(int *retval)
{
	*retval = curproc->uid;
	return 0;
}
