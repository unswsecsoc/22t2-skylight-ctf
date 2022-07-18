FROM ubuntu:20.04

EXPOSE 1194/udp

RUN apt-get update
RUN apt-get install -y openvpn coreutils zip python3 sudo

WORKDIR /etc/openvpn/server
COPY ./openvpn.conf ./server.conf
COPY ./dist/keys.zip ./keys.zip
RUN unzip keys.zip
RUN rm keys.zip

# Hack to allow openvpn to not drop packets with source 1.2.3.4
# Openvpn annoyingly drops packets that can't be returned by default
# so we give it a place to return to
RUN mkdir ccd
RUN echo "iroute 1.2.3.4 255.255.255.255" > ccd/client1

RUN mkdir /intothenetwork
WORKDIR /intothenetwork

COPY ./chal.py ./help.txt ./show_flag ./static_serve.py ./static.html ./
COPY ./facts ./facts

RUN chmod 111 show_flag

RUN useradd chal

COPY ./entry.sh /entry.sh

CMD bash /entry.sh
