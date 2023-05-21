#!/bin/sh

set -euo 'pipefail'

echo "Suwayomi data location inside the container: /home/suwayomi/.local/share/Tachidesk"

if [ ! -f /home/suwayomi/.local/share/Tachidesk/server.conf ]; then
  envsubst < /home/suwayomi/server.conf.template > /home/suwayomi/.local/share/Tachidesk/server.conf
fi

exec java -jar "/home/suwayomi/startup/tachidesk_latest.jar";
