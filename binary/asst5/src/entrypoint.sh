#!/bin/sh

echo '#######################################################################'
echo '#                 Starting nginx, gunicorn, and cron!                 #'
echo '#######################################################################'

nginx
cron
gunicorn --workers 16 app:app
