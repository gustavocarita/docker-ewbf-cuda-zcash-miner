FROM nvidia/cuda:8.0-devel

MAINTAINER Adam Cecile <acecile@le-vert.net>

ENV TERM xterm
ENV HOSTNAME ewbf-cuda-zcash-miner.local
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

# Upgrade base system
RUN apt update \
    && apt -y -o 'Dpkg::Options::=--force-confdef' -o 'Dpkg::Options::=--force-confold' --no-install-recommends dist-upgrade \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt update && apt -y -o 'Dpkg::Options::=--force-confdef' -o 'Dpkg::Options::=--force-confold' --no-install-recommends install wget ca-certificates && rm -rf /var/lib/apt/lists/*

# Install binary
#
# https://bitcointalk.org/index.php?topic=1707546.0
# Go to Google Drive link
# Right click on the file and select "Get shareable link"
# Insert ID in the link below
# 0B9EPp8NdigFiLVVnZDhjc2Vyc3c is "Zec Miner 0.3.4b Linux Bin.tar.gz"
RUN mkdir /root/src \
    && wget "https://drive.google.com/uc?export=download&id=0B9EPp8NdigFiLVVnZDhjc2Vyc3c" -O /root/src/miner.tar.gz \
    && tar xvzf /root/src/miner.tar.gz -C /root/src/ \
    && find /root/src -name 'miner' -exec cp {} /root/ \; \
    && chmod 0755 /root/miner