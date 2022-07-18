obj-m += module.o
module-objs += hasher.o base64.o md5.o sha256.o sha1.o
PWD := $(shell pwd)
ccflags-y :=-std=gnu99

default:
	# Compile for the same architecture as the host machine
	make -C /lib/modules/5.17.5/build M=${PWD} modules

clean:
	# Cleans the Directory - removes all the files that were created
	rm *.mod* *.o *.ko modules.order Module.symvers
	#$(MAKE) -C $(KERNEL_SOURCE) SUBDIRS=${PWD} clean
