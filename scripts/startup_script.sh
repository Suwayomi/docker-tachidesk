#!/bin/sh
if [ ! -f /home/suwayomi/.local/share/Tachidesk/docker_touchfile ]; then
	touch /home/suwayomi/.local/share/Tachidesk/docker_touchfile
	curl -s --create-dirs -L https://raw.githubusercontent.com/Suwayomi/docker-tachidesk/main/server.conf -o /home/suwayomi/.local/share/Tachidesk/server.conf;
fi

if [ -z "$VNC_PASSWORD" ]; then
	echo >&2 'warn: VNC_PASSWORD for VNC connection is not set.'
	export LAUNCH_VNC_CMD=''
else 
	export LAUNCH_VNC_CMD="-passwd $VNC_PASSWORD"
fi

if [ -z "$XFB_SCREEN" ]; then
	export XFB_SCREEN=1024x768x24
fi

if [ ! -z "$XFB_SCREEN_DPI" ]; then
	export DPI_OPTIONS="-dpi $XFB_SCREEN_DPI"
else
    export DPI_OPTIONS=""
fi

# first we need our security cookie and add it to user's .Xauthority
mcookie | sed -e 's/^/add :0 MIT-MAGIC-COOKIE-1 /' | xauth -q

# now place the security cookie with FamilyWild on volume so client can use it
# see http://stackoverflow.com/25280523 for details on the following command
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f /Xauthority/xserver.xauth nmerge -


echo ""
echo ""
echo "                                                                ************README***********"
echo "-> It is essential that u read readme for ghcr.io/suwayomi/tachidesk before running this container"
echo "-> Readme for ghcr.io/suwayomi/tachidesk is available at https://github.com/suwayomi/docker-tachidesk "
echo "                                                                *****************************"
echo ""
echo ""
echo "Tachidesk data location inside the container -> /home/suwayomi/.local/share/Tachidesk"
echo ""
echo "The server is running by default configuration on  http://localhost:4567"
if [ "${LOGGING:-file}" != "file" ]; then
  export TACHIDESK_SDOUT="/dev/fd/1"
else
  echo "log file location inside the container -> /home/suwayomi/.local/share/Tachidesk/logfile.log"
  export TACHIDESK_SDOUT="/home/suwayomi/.local/share/Tachidesk/logfile.log"
fi

exec supervisord -c /home/suwayomi/startup/supervisord.conf