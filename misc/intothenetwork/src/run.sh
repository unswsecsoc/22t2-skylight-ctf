#!/bin/bash

docker build -t vpn-run .
docker run --name vpn-run --rm -p 1194:1194/udp --cap-add=NET_ADMIN -it vpn-run
