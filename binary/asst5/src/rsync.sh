#!/bin/bash

echo "[$(date)] Making sure files in /app/dojo are valid!" >> /app/log.txt

# `rsync` is probably a better solution but I'm too lazy
mkdir -p /app/dojo/bin
cp /app/files/os161/kernel /app/dojo
cp /app/files/os161/sys161.conf /app/dojo
cp /app/files/os161/flag.txt /app/dojo
chown -R sky:sky /app/dojo


