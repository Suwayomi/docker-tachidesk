FROM eclipse-temurin:11-jre-jammy

ARG BUILD_DATE
ARG IMAGE_VERSION
ARG TACHIDESK_GIT_COMMIT
ARG TACHIDESK_RELEASE_TAG
ARG TACHIDESK_FILENAME
ARG TACHIDESK_RELEASE_DOWNLOAD_URL
ARG TACHIDESK_DOCKER_GIT_COMMIT

LABEL maintainer="suwayomi" \
      org.opencontainers.image.title="Suwayomi Docker" \
      org.opencontainers.image.authors="https://github.com/suwayomi" \
      org.opencontainers.image.url="https://github.com/suwayomi/docker-tachidesk/pkgs/container/tachidesk" \
      org.opencontainers.image.source="https://github.com/suwayomi/docker-tachidesk" \
      org.opencontainers.image.description="This image is used to start suwayomi server in a container" \
      org.opencontainers.image.vendor="suwayomi" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.version=$IMAGE_VERSION \
      tachidesk.git_commit=$TACHIDESK_GIT_COMMIT \
      tachidesk.docker_commit=$TACHIDESK_DOCKER_GIT_COMMIT \
      tachidesk.release_tag=$TACHIDESK_RELEASE_TAG \
      tachidesk.filename=$TACHIDESK_FILENAME \
      download_url=$TACHIDESK_RELEASE_DOWNLOAD_URL \
      org.opencontainers.image.licenses="MPL-2.0"

RUN groupadd --gid 1000 suwayomi && \
    useradd  --uid 1000 --gid suwayomi --no-log-init suwayomi && \
    mkdir -p /home/suwayomi && \
    chown -R suwayomi:suwayomi /home/suwayomi
USER suwayomi
WORKDIR /home/suwayomi
RUN curl -s --create-dirs -L $TACHIDESK_RELEASE_DOWNLOAD_URL -o /home/suwayomi/startup/tachidesk_latest.jar
COPY startup_script.sh /home/suwayomi/startup_script.sh

EXPOSE 4567
CMD ["/bin/sh", "/home/suwayomi/startup_script.sh"]

# vim: set ft=dockerfile:
