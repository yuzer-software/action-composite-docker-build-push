ARG BASE_IMAGE
FROM $BASE_IMAGE

ADD install_packages.sh /tmp
RUN sh /tmp/install_packages.sh

ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
    STARTUP_SLEEP=0 \
    JAVA_OPTS=""

CMD echo "The application will start in ${STARTUP_SLEEP}s..." && \
    echo "With Java opts: ${JAVA_OPTS}" && \
    sleep ${STARTUP_SLEEP} && \
    java ${JAVA_OPTS} -XX:+HeapDumpOnOutOfMemoryError -Djava.security.egd=file:/dev/./urandom -jar /app.jar

EXPOSE 8080

ADD *.jar /app.jar