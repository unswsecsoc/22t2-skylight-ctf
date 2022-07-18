#!/bin/sh
docker build -t string_cheese .
docker run -d -p 9999:9999 --name=string_cheese string_cheese
