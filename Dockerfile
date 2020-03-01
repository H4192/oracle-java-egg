# ----------------------------------
# Oracle Java egg for Pterodactyl
# Environment: Java (glibc support)
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        debian:buster-slim

LABEL       author="Markus Selin"

RUN apt-get update -y \
    && apt-get install -y curl ca-certificates openssl git tar wget sqlite fontconfig tzdata iproute2 \
    && useradd -d /home/container -m container
 

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

RUN         cd /usr/java/ \
            && wget -c --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie"  https://download.oracle.com/otn-pub/java/jdk/8u241-b07/1f5b5a70bf22433b84d0e960903adac8/jdk-8u241-linux-x64.tar.gz \
            && tar zxvf jdk-8u241-linux-x64.tar.gz && rm jdk-8u241-linux-x64.tar.gz

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]