FROM alpine:latest

WORKDIR /opt/Lavalink

VOLUME /config

ENV LAVALINK_VERSION=3.2.1
# https://github.com/Frederikam/Laalink/releases/download/3.2.1/Lavalink.jar

# Update system
RUN apk update && apk update

RUN apk add wget openjdk8-jre-base

RUN wget "https://github.com/Frederikam/Lavalink/releases/download/${LAVALINK_VERSION}/Lavalink.jar" -P /opt/Lavalink

RUN ln -s /config/application.yml /opt/Lavalink/application.yml

EXPOSE 2333

CMD ["java", "-jar", "Lavalink.jar"]