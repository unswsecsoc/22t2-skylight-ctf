#!/bin/sh

# Author: Jarrod Cameron (z5210220)
# Date:   06/28/22 16:44

# Exit on non-zero return status
set -e

# Compile userland bins
bmake -j `nproc`
bmake -j `nproc` install

# Configure
pushd kern/conf
./config SKYCTF
popd

pushd kern/compile/SKYCTF
bmake -j `nproc` depend
bmake -j `nproc`
bmake -j `nproc` install
popd

/bin/echo -n 'SKYLIGHT{looking_forward_to_seeing_some_kernel_0days_cb70}' > ~/os161/root/flag.txt

cat > ~/os161/root/sys161.conf << EOF
0       serial
1       emufs
28      random  autoseed
29      timer
30      trace
31      mainboard  ramsize=524288  cpus=1
EOF

pushd ~/os161/root/
os161-strip --strip-debug kernel
sys161 kernel "$@"
popd
