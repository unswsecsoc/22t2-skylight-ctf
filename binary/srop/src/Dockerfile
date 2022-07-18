FROM ubuntu:18.04
SHELL ["/bin/bash", "-eucx"]

RUN dpkg --add-architecture i386
RUN apt-get update && \
    apt-get install -yq \
    libc6:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \ 
    socat && \
    rm -rf /var/lib/apt/lists/*

# Create CTF user
RUN mkdir /home/ctf && \
    chmod 755 /home/ctf && \
    useradd -M -U -d /home/ctf ctf && \
    chown ctf:ctf /home/ctf
WORKDIR /home/ctf

# Copy challenge + flag
COPY ./src/srop .
COPY ./src/flag.txt .
RUN chmod 755 srop && \
    chmod 644 flag.txt && \ 
    chown -R ctf: .

# Copy Script
COPY ./run.sh /
RUN chmod 500 /run.sh

# Expose container
EXPOSE 1337

# Run script when the container launches
ENTRYPOINT ["/run.sh"]

