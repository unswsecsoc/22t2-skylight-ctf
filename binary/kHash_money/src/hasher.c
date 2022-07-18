#include <linux/module.h>
#include <linux/slab.h>
#include <linux/kernel.h>
#include <linux/uaccess.h>
#include <linux/device.h>
#include <linux/cdev.h>
#include <linux/fs.h>
#include "hasher.h"
#include "base64.h"
#include "md5.h"
#include "sha256.h"
#include "sha1.h"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("SECSOC");
MODULE_DESCRIPTION("Hashing via a kernel device!");

static long hash_ioctl(struct file * filp, unsigned int cmd, unsigned long arg);

dev_t dev_handle;
struct class * cl;
struct cdev c_dev;

struct hash_obj *  hasher;

struct file_operations fops = {
	.owner = THIS_MODULE,
	.unlocked_ioctl = hash_ioctl,
};


int init_module()
{
	int res = alloc_chrdev_region(&dev_handle, 0, 1,"hasher");
	if (res < 0) {
		printk(KERN_ALERT "Failed to register device with %d\n", res);
		return -1;
	}

	cl = class_create(THIS_MODULE, "hasher_class");
	if (cl == NULL) {
		printk(KERN_ALERT "class registration failed\n");
		unregister_chrdev_region ( dev_handle, 1);
		return -1;
	}

	if (device_create(cl, NULL, dev_handle, NULL, "hasher") == NULL) {
		printk(KERN_ALERT "Device creation failed\n");
		class_destroy(cl);
		unregister_chrdev_region ( dev_handle, 1);
		return -1;
	}

	cdev_init(&c_dev, &fops);

	if (cdev_add(&c_dev, dev_handle, 1) == -1) {
		printk(KERN_ALERT "Device addition failed\n");
		device_destroy(cl, dev_handle);
		class_destroy(cl);
		unregister_chrdev_region ( dev_handle, 1);
		return -1;
	}

	printk(KERN_ALERT "Device registered.\n");

	return 0;
}

void cleanup_module()
{
	cdev_del(&c_dev);
	device_destroy(cl, dev_handle);
	class_destroy(cl);
	unregister_chrdev_region ( dev_handle, 1);

	printk(KERN_ALERT "Device unregistered.\n");
}


static long hash_ioctl(struct file * filp, unsigned int cmd, unsigned long arg) {

	switch(cmd) {
		case HASH_INIT:
			switch(arg) {
				case HASH_BASE64:
					hasher = &BASE64_HASHER;
					break;
				case HASH_MD5:
					hasher = &MD5_HASHER;
					break;
				case HASH_SHA256:
					hasher = &SHA256_HASHER;
					break;
				case HASH_SHA1:
					hasher = &SHA1_HASHER;
					break;
				default:
					return HASH_UNDEFINED;

			};
			break;
		case HASH_ENCODE:
			if (hasher != NULL) {
				//TODO: probs just kmalloc a chunk for the user_req and copy it in to be cleaner
				struct user_req * req = (struct user_req*)arg;
				unsigned int len = req->len;
				hasher->ctx.msg_len = len;
				char * in_data = kmalloc(len, GFP_KERNEL);
				char * out_data = kzalloc(2*len, GFP_KERNEL);
				copy_from_user( in_data, req->in, len); 

				hasher->ops.encode(&hasher->ctx, in_data, out_data);

				copy_to_user(req->out, out_data, hasher->ctx.msg_len);
				kfree(in_data);
				kfree(out_data);
			}
			break;
		case HASH_DECODE:
			if (hasher != NULL) {
				struct user_req * req = (struct user_req*)arg;
				unsigned int len = req->len;
				hasher->ctx.msg_len = len;
				char * in_data = kmalloc(len, GFP_KERNEL);
				char * out_data = kzalloc(2*len, GFP_KERNEL);
				copy_from_user( in_data, req->in, len); 

				hasher->ops.decode(&hasher->ctx, in_data, out_data);

				copy_to_user(req->out, out_data, hasher->ctx.msg_len);
				kfree(in_data);
				kfree(out_data);
			}
			break;
		case HASH_INFO:
			if (hasher != NULL) {
				char * info = kzalloc(0x1000, GFP_KERNEL);
				struct user_req * req = (struct user_req*)arg;
				
				hasher->ops.info(&hasher->ctx, info);

				copy_to_user(req->out, info, strlen(info));
				kfree(info);
			}
			break;
		default:
			return HASH_UNDEFINED;
	}

	return 0;
}
