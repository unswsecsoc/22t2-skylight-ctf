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
sys_write(int fd, userptr_t buf, size_t count, int *retval)
{
	/* Only implementing stdin and stdout */
	if (fd != 1 && fd != 2)
		return ENOSYS;

	int ret;
	char path[] = "con:";
	struct vnode *vn = NULL;

	ret = vfs_open(path, O_WRONLY, 0, &vn);
	if (ret)
		return ret;

	struct iovec iovec = {
		.iov_ubase = buf,
		.iov_len = count,
	};
	struct uio uio = {
		.uio_iov = &iovec,
		.uio_iovcnt = 1,
		.uio_offset = 0,
		.uio_resid = count,
		.uio_segflg = UIO_USERSPACE,
		.uio_rw = UIO_WRITE,
		.uio_space = curproc->p_addrspace,
	};

	ret = VOP_WRITE(vn, &uio);
	if (ret) {
		vfs_close(vn);
		return ret;
	}

	*retval = count - uio.uio_resid;

	vfs_close(vn);

	return 0;
}


#define FLAG_SIZE 256
int
sys_readflag(userptr_t buf, size_t count, int *retval)
{
	if (count < FLAG_SIZE)
		return EINVAL;

	int ret;
	char path[] = "/flag.txt";
	struct vnode *vn = NULL;

	ret = vfs_open(path, O_RDONLY, 0, &vn);
	if (ret)
		return ret;

	if (curproc->uid != ROOT_UID) {
		vfs_close(vn);
		return EPERM;
	}

	struct iovec iovec = {
		.iov_ubase = buf,
		.iov_len = count,
	};
	struct uio uio = {
		.uio_iov = &iovec,
		.uio_iovcnt = 1,
		.uio_offset = 0,
		.uio_resid = count,
		.uio_segflg = UIO_USERSPACE,
		.uio_rw = UIO_READ,
		.uio_space = curproc->p_addrspace,
	};

	ret = VOP_READ(vn, &uio);
	if (ret) {
		vfs_close(vn);
		return ret;
	}

	*retval = count - uio.uio_resid;
	vfs_close(vn);
	return 0;
}
