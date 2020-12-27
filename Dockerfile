FROM openjdk:11-jdk-slim

WORKDIR /app
COPY target/ .
ENTRYPOINT [ "java", "-jar", "estore-1.0.war" ]
