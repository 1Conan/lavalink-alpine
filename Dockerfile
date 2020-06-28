FROM adoptopenjdk/openjdk14:alpine-jre

VOLUME /config

ENV LAVALINK_VERSION=3.3.1

# Update system
RUN apk update --no-cache
RUN apk add --no-cache wget ca-certificates nss mpg123

# Run as non-root user
RUN addgroup -g 322 lavalink && \
    adduser -S -u 322 -G lavalink lavalink

WORKDIR /opt/Lavalink

RUN chown lavalink:lavalink /opt/Lavalink

USER lavalink

RUN wget "https://github.com/Frederikam/Lavalink/releases/download/${LAVALINK_VERSION}/Lavalink.jar" -P /opt/Lavalink

RUN ln -s /config/application.yml /opt/Lavalink/application.yml

USER root

RUN apk del wget ca-certificates

EXPOSE 2333

CMD ["java", "-Djdk.tls.client.protocols=TLSv1.1,TLSv1.2", "-Xmx1G", "-jar", "Lavalink.jar"]
