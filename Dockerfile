FROM adoptopenjdk/openjdk11:alpine-jre

VOLUME /config

ENV LAVALINK_VERSION=3.3
# https://github.com/Frederikam/Laalink/releases/download/3.2.1/Lavalink.jar

# Update system
RUN apk update
RUN apk add wget nss mpg123

# Run as non-root user
RUN addgroup -g 322 lavalink && \
    adduser -S -u 322 -G lavalink lavalink
USER lavalink

WORKDIR /opt/Lavalink

RUN wget "https://github.com/Frederikam/Lavalink/releases/download/${LAVALINK_VERSION}/Lavalink.jar" -P /opt/Lavalink

RUN ln -s /config/application.yml /opt/Lavalink/application.yml

EXPOSE 2333

CMD ["java", "-Djdk.tls.client.protocols=TLSv1.1,TLSv1.2", "-Xmx1G", "-jar", "Lavalink.jar"]
