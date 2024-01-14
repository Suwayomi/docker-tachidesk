#!/bin/bash

set -e

export PUID="${PUID:-"1000"}"
export PGID="${PGID:-"1000"}"
ARGS=()

if [[ "${UID}" = 0 ]]; then
  echo "Running as root, changing to $PUID:$PGID"
  # this ensures the existing files created in the image can be read
  usermod suwayomi -u "$PUID" -g "$PGID"
  # use gosu to change UID/GID
  ARGS+=(gosu "$PUID:$PGID")
else
  echo "Running as $(id -u):$(id -g)"
fi

# use the eclipse-temurin entrypoint and execute the program specified in the
# arguments.
# If the UID is 0, use GOSU to change to PUID/PGUD
exec "/__cacert_entrypoint.sh" "${ARGS[@]}" "$@"
