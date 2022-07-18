#!/bin/bash
app="oweek-netcat"
docker build -t ${app} .
docker run -d -p 23:9999 --name=${app} -v $PWD:/app ${app}
