FROM ubuntu:jammy-20240416 AS base

USER root

RUN apt update && apt install -y gcc make 
RUN apt-get install -y isc-dhcp-client nano curl net-tools iputils-ping
RUN apt-get update && apt-get install -y libicu-dev

COPY softether-vpnclient.tar.gz /tmp/softether-vpnclient.tar.gz

RUN tar -xvf /tmp/softether-vpnclient.tar.gz -C /opt

RUN rm /tmp/softether-vpnclient.tar.gz

WORKDIR /opt/vpnclient

COPY run.sh ./run.sh

RUN mkdir app

COPY app/* app

RUN sh .install.sh

RUN ./vpnclient start

WORKDIR /opt/vpnclient/app

# CMD ["/bin/sh", "run.sh"]
ENTRYPOINT ["./Aron.VPN.Controller"]

