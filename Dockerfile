FROM openjdk:21-jdk-slim-bullseye AS builder

LABEL maintainer="yggd@yahoo.co.jp"

ARG MC_VERSION="1.20.4"
ARG SPIGOT_HOME=/opt/spigot/$MC_VERSION

WORKDIR /var/spigotbuild

RUN set -eux; \
         apt-get update; \
         apt-get install -y binutils wget git; \
         wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

RUN set -eux; \
         java -jar BuildTools.jar --rev $MC_VERSION; \
         mkdir -p $SPIGOT_HOME; \
         cp spigot-${MC_VERSION}.jar $SPIGOT_HOME/spigot.jar; \
         echo "eula=true" > $SPIGOT_HOME/eula.txt


FROM openjdk:21-jdk-slim-bullseye 

RUN set -eux; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
                ca-certificates p11-kit \
                locales; \
	rm -rf /var/lib/apt/lists/*; \
        localedef -f UTF-8 -i ja_JP ja_JP

ARG MC_VERSION="1.20.4"
ARG SPIGOT_HOME=/opt/spigot/$MC_VERSION

ENV LANG='ja_JP.UTF-8' LANGUAGE='ja_JP:ja' LC_ALL='ja_JP.UTF-8'
ENV TZ='Asia/Tokyo'

COPY --from=builder $SPIGOT_HOME $SPIGOT_HOME

RUN set -eux; \
        groupadd -g 1000 minecraft; \
        useradd  -g      minecraft -m -s /bin/bash spigot; \
        mkdir -p $SPIGOT_HOME/worlds; \
        mkdir -p $SPIGOT_HOME/Backups; \
        chown -R spigot:minecraft $SPIGOT_HOME

USER spigot

WORKDIR $SPIGOT_HOME

CMD ["java",  "-Xms2G", "-Xmx2G", "-XX:+UseG1GC", "-jar", "spigot.jar", "--nogui", "--world-dir", "./worlds"]

