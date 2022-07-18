# Basic Xinetd Docker Container
FROM ubuntu:18.04

# Apt-get update
RUN apt-get update && \
    apt-get install -y xinetd && \
	apt-get install -y gcc && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y python3-minimal

# optional: install 32-bit libraries
# RUN dpkg --add-architecture i386 && \
#     apt-get update && \
#     apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386

# Create CTF user
RUN mkdir /home/ctf && \
    chmod 755 /home/ctf && \
    useradd -M -U -d /home/ctf ctf && \
    chown ctf:ctf /home/ctf
COPY xinetd.conf /etc/

# Copy binary
COPY ./string_cheese.c /home/ctf/
COPY ./flag /home/ctf/


RUN gcc -o /home/ctf/main /home/ctf/string_cheese.c
# Make the binary
RUN chmod 755 /home/ctf/main && \
	chmod 755 /home/ctf/flag && \
    chown -R ctf: /home/ctf

# Expose container
EXPOSE 9999

# Run script when the container launches
CMD ["script", "-c", "xinetd -d -dontfork"]
