# Tachidesk-docker

| Status | Stable |Preview | Discord Support|
|:-:|:-:|:-:|:-:|
| [![Build Docker Images](https://github.com/suwayomi/docker-tachidesk/actions/workflows/build_container_images.yml/badge.svg)](https://github.com/suwayomi/docker-tachidesk/actions/workflows/build_container_images.yml) [![Docker Pulls](https://img.shields.io/badge/dynamic/json?url=https://github.com/suwayomi/docker-tachidesk/raw/main/scripts/tachidesk_version.json&label=docker_pulls&query=$.total_downloads&color=blue)](https://github.com/orgs/suwayomi/packages/container/package/tachidesk) | [![Latest](https://img.shields.io/badge/dynamic/json?url=https://github.com/suwayomi/docker-tachidesk/raw/main/scripts/tachidesk_version.json&label=version&query=$.stable&color=blue)](https://github.com/orgs/suwayomi/packages/container/package/tachidesk/) | [![Preview](https://img.shields.io/badge/dynamic/json?url=https://github.com/suwayomi/docker-tachidesk/raw/main/scripts/tachidesk_version.json&label=version&query=$.preview&color=blue)](https://github.com/orgs/suwayomi/packages/container/package/tachidesk) | [![Discord](https://img.shields.io/discord/801021177333940224.svg?label=discord&labelColor=7289da&color=2c2f33&style=flat)](https://discord.gg/DDZdqZWaHA) |

Run [Tachidesk](https://github.com/Suwayomi/Tachidesk) server inside docker container as non-root user. The server will be running on http://localhost:4567 open this url in your browser.

Docker Releases - https://github.com/suwayomi/docker-tachidesk/pkgs/container/tachidesk

Dockerfile - https://github.com/suwayomi/docker-tachidesk

_**Tachidesk data location - /home/suwayomi/.local/share/Tachidesk**_

Docker images are mutli-arch (linux/386, linux/amd64, linux/arm/v6, linux/arm/v7, linux/arm64, linux/ppc64le, linux/s390x) and has very small size based on alpine linux.

Log file location - /home/suwayomi/.local/share/Tachidesk/logfile.log

# Docker compose
Use the template compose.yml in this repo for creating and starting tachidesk docker container.  

# Docker commands

Expose to localhost ip

    docker run -p 127.0.0.1:4567:4567 ghcr.io/suwayomi/tachidesk

Expose to specific ip

    docker run -p 192.168.x.x:4567:4567 ghcr.io/suwayomi/tachidesk

Expose to all ips

    docker run -p 4567:4567 ghcr.io/suwayomi/tachidesk

Change the default UTC timezone. Use TZ database name from [Timezone list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

    docker run -e "TZ=Europe/London" -p 127.0.0.1:4567:4567 ghcr.io/suwayomi/tachidesk
	
For Tachidesk Preview version

     docker run -p 127.0.0.1:4567:4567 ghcr.io/suwayomi/tachidesk:preview

Persistent data of tachidesk on subsequent run

    docker run -p 127.0.0.1:4567:4567 -v <folder path>:/./home/suwayomi/.local/share/Tachidesk ghcr.io/suwayomi/tachidesk   
	 
For Specific Tachidesk stable version (from v0.3.9 onwards)

     docker run -p 127.0.0.1:4567:4567 ghcr.io/suwayomi/tachidesk:v0.3.9

# Credit

[Tachidesk](https://github.com/Suwayomi/Tachidesk) is licensed under `MPL v. 2.0`.

# License

    This Source Code Form is subject to the terms of the Mozilla Public
    License, v. 2.0. If a copy of the MPL was not distributed with this
    file, You can obtain one at http://mozilla.org/MPL/2.0/.
