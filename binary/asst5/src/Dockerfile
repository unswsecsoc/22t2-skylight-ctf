FROM ubuntu

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y cron gunicorn nginx python3 python3-pip unzip
RUN python3 -m pip install --upgrade flask

# Files needs to run webserver, nginx, and os161
RUN mkdir -p /app/dojo/bin /app/files/os161 /run
RUN touch /app/log.txt

COPY app.py /app
COPY entrypoint.sh /root/entrypoint.sh
# COPY files.zip /app/files.zip
COPY files/ /app/files/
COPY flask_app /etc/nginx/sites-enabled/flask_app
COPY rsync.sh /app/rsync.sh
COPY rsync_cron /etc/cron.d/rsync_cron

# Everything we do is in the /app directory
WORKDIR /app

# Extract files and `rm` to save space
# RUN unzip files.zip
# RUN rm files.zip

# Update placeholder flag with real flag
RUN /bin/echo -n 'SKYLIGHT{Lo0k1nG_f0rWArD_t0_$3E1ng_$om3_KeRnEl_0DAyz_cb70}' > /app/files/os161/flag.txt

# Files that the low priv user can write to
RUN cp /app/files/os161/kernel /app/dojo
RUN cp /app/files/os161/sys161.conf /app/dojo
RUN cp /app/files/os161/flag.txt /app/dojo

# Low priv user
RUN useradd -ms /bin/bash sky
RUN chown -R sky:sky /app/dojo

# No idea what this does, just saw it on a blog post
RUN unlink /etc/nginx/sites-enabled/default

EXPOSE 3891

CMD ["/bin/bash", "/root/entrypoint.sh"]
