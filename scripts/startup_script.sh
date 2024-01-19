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
export BASIC_AUTH_ENABLED="${BASIC_AUTH_ENABLED:-false}"
export BASIC_AUTH_USERNAME="${BASIC_AUTH_USERNAME:-""}"
export BASIC_AUTH_PASSWORD="${BASIC_AUTH_PASSWORD:-""}"
export DEBUG="${DEBUG:-true}"
export GQL_DEBUG="${GQL_DEBUG:-false}"
export WEB_UI_FLAVOR="${WEB_UI_FLAVOR:-"WebUI"}"
export WEB_UI_CHANNEL="${WEB_UI_CHANNEL:-"stable"}"
export WEB_UI_UPDATE_INTERVAL="${WEB_UI_UPDATE_INTERVAL:-23}"
export AUTO_DOWNLOAD_CHAPTERS="${AUTO_DOWNLOAD_CHAPTERS:-false}"
export AUTO_DOWNLOAD_EXCLUDE_UNREAD="${AUTO_DOWNLOAD_EXCLUDE_UNREAD:-true}"
export AUTO_DOWNLOAD_AHEAD_LIMIT="${AUTO_DOWNLOAD_AHEAD_LIMIT:-0}"
export MAX_SOURCES_IN_PARALLEL="${MAX_SOURCES_IN_PARALLEL:-6}"
export UPDATE_EXCLUDE_UNREAD="${UPDATE_EXCLUDE_UNREAD:-true}"
export UPDATE_EXCLUDE_STARTED="${UPDATE_EXCLUDE_STARTED:-true}"
export UPDATE_EXCLUDE_COMPLETED="${UPDATE_EXCLUDE_COMPLETED:-true}"
export UPDATE_INTERVAL="${UPDATE_INTERVAL:-12}"
export UPDATE_MANGA_INFO="${UPDATE_MANGA_INFO:-false}"
export BACKUP_TIME="${BACKUP_TIME:-"00:00"}"
export BACKUP_INTERVAL="${BACKUP_INTERVAL:-1}"
export BACKUP_TTL="${BACKUP_TTL:-14}"
export EXTENSION_REPOS="${EXTENSION_REPOS:-"[]"}"

USERNAME="suwayomi"
HOME="/home/${USERNAME}"

# add UID/GID to /etc/passwd if missing, in order for Java's user.home property to work correctly with non default UIDs.
if ! whoami  >/dev/null 2>&1; then
  if [ -w /etc/passwd ]; then
    echo "Adding user ${USERNAME} with current UID:GID $(id -u):$(id -g) to /etc/passwd"
    # Remove existing entry with user first.
    # cannot use sed -i because we do not have permission to write new
    # files into /etc
    sed  "/${USERNAME}:x/d" /etc/passwd > /tmp/passwd
    # add our user with our current user ID into passwd
    echo "${USERNAME}:x:$(id -u):$(id -g):${USERNAME} user:${HOME}:/bin/bash" >> /tmp/passwd
    # overwrite existing contents with new contents (cannot replace the
    # file due to permissions)
    cat /tmp/passwd > /etc/passwd
    rm /tmp/passwd
  fi
fi

envsubst < /home/suwayomi/server.conf.template > /home/suwayomi/.local/share/Tachidesk/server.conf

exec java -jar "/home/suwayomi/startup/tachidesk_latest.jar";
