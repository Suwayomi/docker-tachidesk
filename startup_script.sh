#!/bin/sh

# Immediately bail out if any command fails:
set -e

echo "Suwayomi data location inside the container: /home/suwayomi/.local/share/Tachidesk"

# set default values for environment variables:
export TZ="${TZ:-Etc/UTC}"
export BIND_IP="${BIND_IP:-0.0.0.0}"
export BIND_PORT="${BIND_PORT:-4567}"
export SOCKS_PROXY_ENABLED="${SOCKS_PROXY_ENABLED:-false}"
export SOCKS_PROXY_HOST="${SOCKS_PROXY_HOST:-""}"
export SOCKS_PROXY_PORT="${SOCKS_PROXY_PORT:-""}"
export DOWNLOAD_AS_CBZ="${DOWNLOAD_AS_CBZ:-false}"
export MAX_PARALLEL_UPDATE="${MAX_PARALLEL_UPDATE:-10}"
export BASIC_AUTH_ENABLED="${BASIC_AUTH_ENABLED:-false}"
export BASIC_AUTH_USERNAME="${BASIC_AUTH_USERNAME:-""}"
export BASIC_AUTH_PASSWORD="${BASIC_AUTH_PASSWORD:-""}"
export DEBUG="${DEBUG:-true}"

envsubst < /home/suwayomi/server.conf.template > /home/suwayomi/.local/share/Tachidesk/server.conf

exec java -jar "/home/suwayomi/startup/tachidesk_latest.jar";
