#!/bin/bash
docker build -t cbcrsa .
docker run --rm -p 3000:80 cbcrsa
