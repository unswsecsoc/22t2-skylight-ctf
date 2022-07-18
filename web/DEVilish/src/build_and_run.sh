#!/bin/bash
docker build -t devilish .
docker run --rm -p 3000:80 devilish
