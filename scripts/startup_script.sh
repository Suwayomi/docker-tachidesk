#!/bin/sh

# Immediately bail out if any command fails:
set -e

echo "Suwayomi data location inside the container: /home/suwayomi/.local/share/Tachidesk"

# make sure the server.conf file exists
/home/suwayomi/create_server_conf.sh

# set default values for environment variables:
export TZ="${TZ:-Etc/UTC}"

# Set default values for settings
sed -i -r "s/server.initialOpenInBrowserEnabled = (.*)/server.initialOpenInBrowserEnabled = false/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.systemTrayEnabled = (.*)/server.systemTrayEnabled = false/" /home/suwayomi/.local/share/Tachidesk/server.conf

# Overwrite configuration values with environment variables
# Server ip and port bindings
sed -i -r "s/server.ip = \"(.*)\"/server.ip = \"${BIND_IP:-\1}\"/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.port = (.*)/server.port = ${BIND_PORT:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf

# Socks5 proxy
sed -i -r "s/server.socksProxyEnabled = (.*)/server.socksProxyEnabled = ${SOCKS_PROXY_ENABLED:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.socksProxyHost = \"(.*)\"/server.socksProxyHost = \"${SOCKS_PROXY_HOST:-\1}\"/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.socksProxyPort = \"(.*)\"/server.socksProxyPort = \"${SOCKS_PROXY_PORT:-\1}\"/" /home/suwayomi/.local/share/Tachidesk/server.conf

# webUI
sed -i -r "s/server.webUIEnabled = (.*)/server.webUIEnabled = ${WEB_UI_EABLED:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.webUIFlavor = \"(.*)\"/server.webUIFlavor = \"${WEB_UI_FLAVOR:-\1}\"/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.webUIChannel = \"(.*)\"/server.webUIChannel = \"${WEB_UI_CHANNEL:-\1}\"/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.webUIUpdateCheckInterval = (.*)/server.webUIUpdateCheckInterval = ${WEB_UI_UPDATE_INTERVAL:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf

# downloader
sed -i -r "s/server.downloadAsCbz = (.*)/server.downloadAsCbz = ${DOWNLOAD_AS_CBZ:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.autoDownloadNewChapters = (.*)/server.autoDownloadNewChapters = ${AUTO_DOWNLOAD_CHAPTERS:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.excludeEntryWithUnreadChapters = (.*)/server.excludeEntryWithUnreadChapters = ${AUTO_DOWNLOAD_EXCLUDE_UNREAD:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.autoDownloadAheadLimit = (.*)/server.autoDownloadAheadLimit = ${AUTO_DOWNLOAD_AHEAD_LIMIT:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf

# extension repos
if [ -n "$EXTENSION_REPOS" ]; then
    perl -0777 -i -pe 's/server\.extensionRepos = (\[.*\])/server.extensionRepos = $ENV{EXTENSION_REPOS}/gs' /home/suwayomi/.local/share/Tachidesk/server.conf
fi

# requests
sed -i -r "s/server.maxSourcesInParallel = (.*)/server.maxSourcesInParallel = ${MAX_SOURCES_IN_PARALLEL:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf

# updater
sed -i -r "s/server.excludeUnreadChapters = (.*)/server.excludeUnreadChapters = ${UPDATE_EXCLUDE_UNREAD:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.excludeNotStarted = (.*)/server.excludeNotStarted = ${UPDATE_EXCLUDE_STARTED:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.excludeCompleted = (.*)/server.excludeCompleted = ${UPDATE_EXCLUDE_COMPLETED:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.globalUpdateInterval = (.*)/server.globalUpdateInterval = ${UPDATE_INTERVAL:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.updateMangas = (.*)/server.updateMangas = ${UPDATE_MANGA_INFO:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf

# Authentication
sed -i -r "s/server.basicAuthEnabled = (.*)/server.basicAuthEnabled = ${BASIC_AUTH_ENABLED:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.basicAuthUsername = \"(.*)\"/server.basicAuthUsername = \"${BASIC_AUTH_USERNAME:-\1}\"/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.basicAuthPassword = \"(.*)\"/server.basicAuthPassword = \"${BASIC_AUTH_PASSWORD:-\1}\"/" /home/suwayomi/.local/share/Tachidesk/server.conf

# misc
sed -i -r "s/server.debugLogsEnabled = (.*)/server.debugLogsEnabled = ${DEBUG:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.gqlDebugLogsEnabled = (.*)/server.gqlDebugLogsEnabled = ${GQL_DEBUG:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf

# backup
sed -i -r "s/server.backupTime = (.*)/server.backupTime = ${BACKUP_TIME:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.backupInterval = (.*)/server.backupInterval = ${BACKUP_INTERVAL:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.backupTTL = (.*)/server.backupTTL = ${BACKUP_TTL:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf


# cloudflare bypass
sed -i -r "s/server.flareSolverrEnabled = (.*)/server.flareSolverrEnabled = ${FLARESOLVERR_ENABLED:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s|server.flareSolverrUrl = \"(.*)\"|server.flareSolverrUrl = \"${FLARESOLVERR_URL:-\1}\"|" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.flareSolverrTimeout = (.*)/server.flareSolverrTimeout = ${FLARESOLVERR_TIMEOUT:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.flareSolverrSessionName = \"(.*)\"/server.flareSolverrSessionName = \"${FLARESOLVERR_SESSION_NAME:-\1}\"/" /home/suwayomi/.local/share/Tachidesk/server.conf
sed -i -r "s/server.flareSolverrSessionTtl = (.*)/server.flareSolverrSessionTtl = ${FLARESOLVERR_SESSION_TTL:-\1}/" /home/suwayomi/.local/share/Tachidesk/server.conf

exec java -Duser.home=/home/suwayomi -jar "/home/suwayomi/startup/tachidesk_latest.jar";
