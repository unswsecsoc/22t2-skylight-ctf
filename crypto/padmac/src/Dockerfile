FROM python:3.8-slim

EXPOSE 80

RUN apt-get clean \
    && apt-get -y update

RUN apt-get -y install nginx \
    && apt-get -y install python3-dev \
    && apt-get -y install build-essential

WORKDIR /srv/app

COPY requirements.txt ./

RUN pip install -r requirements.txt --src /usr/local/src

COPY app.py wsgi.py util.py uwsgi.ini ./
COPY templates ./templates

COPY nginx.conf /etc/nginx/

CMD service nginx start && uwsgi --ini uwsgi.ini
