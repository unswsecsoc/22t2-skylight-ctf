#!/bin/bash
CH=srop

docker build --tag="$CH" .
docker container stop "$CH" && docker container rm "$CH"
docker run -it -d --name="$CH" -p 1337:1337 --restart=always "$CH:latest"
