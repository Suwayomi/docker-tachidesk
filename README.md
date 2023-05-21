# Tachidesk-docker

| Status | Stable |Preview | Discord Support|
|:-:|:-:|:-:|:-:|
| [![Build Docker Images](https://github.com/suwayomi/docker-tachidesk/actions/workflows/build_container_images.yml/badge.svg)](https://github.com/suwayomi/docker-tachidesk/actions/workflows/build_container_images.yml) [![Docker Pulls](https://img.shields.io/badge/dynamic/json?url=https://github.com/suwayomi/docker-tachidesk/raw/main/scripts/tachidesk_version.json&label=docker_pulls&query=$.total_downloads&color=blue)](https://github.com/orgs/suwayomi/packages/container/package/tachidesk) | [![Latest](https://img.shields.io/badge/dynamic/json?url=https://github.com/suwayomi/docker-tachidesk/raw/main/scripts/tachidesk_version.json&label=version&query=$.stable&color=blue)](https://github.com/orgs/suwayomi/packages/container/package/tachidesk/) | [![Preview](https://img.shields.io/badge/dynamic/json?url=https://github.com/suwayomi/docker-tachidesk/raw/main/scripts/tachidesk_version.json&label=version&query=$.preview&color=blue)](https://github.com/orgs/suwayomi/packages/container/package/tachidesk) | [![Discord](https://img.shields.io/discord/801021177333940224.svg?label=discord&labelColor=7289da&color=2c2f33&style=flat)](https://discord.gg/DDZdqZWaHA) |

Run [Tachidesk-Server](https://github.com/Suwayomi/Tachidesk-Server) inside docker container as non-root user. The server will be running on http://localhost:4567 open this url in your browser.

Docker Releases - https://github.com/suwayomi/docker-tachidesk/pkgs/container/tachidesk

Dockerfile - https://github.com/suwayomi/docker-tachidesk

_**Tachidesk data location - /home/suwayomi/.local/share/Tachidesk**_

Docker images are mutli-arch (linux/amd64, linux/arm/v7, linux/arm64, linux/ppc64le, linux/s390x) and has small size based on Ubuntu linux.

Logs are sent to stdout and are not written to disk.

### Docker compose
Use the template [docker-compose.yml](./docker-compose.yml) in this repo for creating and starting tachidesk docker container.

# Environment Variables

There are a number of environment variables available to configure Suwayomi:

| Variable | Default | Description |
|:-:|:-:|:-:|
| **BIND_IP** | `0.0.0.0` | The interface to listen on, inside the container. You almost never want to change this. |
| **BIND_PORT** | `4567` | Which port Suwayomi will listen on |
| **SOCKS_PROXY_ENABLED** | `true` | Whether Suwayomi will connect through a SOCKS5 proxy |
| **SOCKS_PROXY_HOST** | `0.0.0.0` | The TCP host of the SOCKS5 proxy |
| **SOCKS_PROXY_PORT** | `0.0.0.0` | The port of the SOCKS5 proxy |
| **DOWNLOAD_AS_CBZ** | `false` | Whether Suwayomi should save the manga to disk in CBZ format |
| **MAX_PARALLEL_UPDATE** | `10` | How many sources can be updated at the same time? |
| **BASIC_AUTH_ENABLED** | `false` | Whether Suwayomi requires HTTP Basic Auth to get in. |
| **BASIC_AUTH_USERNAME** | `""` | The username to log in to Suwayomi. |
| **BASIC_AUTH_PASSWORD** | `""` | The password to log in to Suwayomi. |
| **DEBUG** | `true` | If extra logging is enabled. Useful for development and troubleshooting. |

# Docker tags

## Stable

`ghcr.io/suwayomi/tachidesk:stable`

The latest stable release of the server.

## Preview

`ghcr.io/suwayomi/tachidesk:preview`

The latest preview release of the server. Can be buggy!

## Latest

`ghcr.io/suwayomi/tachidesk:latest`

The most recent container to be created, can be either the stable or preview versions. Be careful!

# Docker commands

Expose to localhost ip

    docker run -p 127.0.0.1:4567:4567 ghcr.io/suwayomi/tachidesk:stable

Expose to specific ip

    docker run -p 192.168.x.x:4567:4567 ghcr.io/suwayomi/tachidesk:stable

Expose to all ips

    docker run -p 4567:4567 ghcr.io/suwayomi/tachidesk:stable

Change the default UTC timezone. Use TZ database name from [Timezone list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

    docker run -e "TZ=Europe/London" -p 127.0.0.1:4567:4567 ghcr.io/suwayomi/tachidesk:stable

Change the logging location from a file to standard output

    docker run -e "LOGGING=out" -p 127.0.0.1:4567:4567 ghcr.io/suwayomi/tachidesk:stable

For Tachidesk Preview version

     docker run -p 127.0.0.1:4567:4567 ghcr.io/suwayomi/tachidesk:preview

Persistent data of tachidesk on subsequent run

    docker run -p 127.0.0.1:4567:4567 -v <folder path>:/./home/suwayomi/.local/share/Tachidesk ghcr.io/suwayomi/tachidesk

For Specific Tachidesk stable version (from v0.3.9 onwards)

     docker run -p 127.0.0.1:4567:4567 ghcr.io/suwayomi/tachidesk:v0.3.9

# Credit

[Tachidesk-Server](https://github.com/Suwayomi/Tachidesk-Server) is licensed under `MPL v. 2.0`.

# License

    This Source Code Form is subject to the terms of the Mozilla Public
    License, v. 2.0. If a copy of the MPL was not distributed with this
    file, You can obtain one at http://mozilla.org/MPL/2.0/.
