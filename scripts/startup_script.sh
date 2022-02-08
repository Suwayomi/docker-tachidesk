#!/bin/sh
if [ ! -f /home/suwayomi/.local/share/Tachidesk/docker_touchfile ]; then
	touch /home/suwayomi/.local/share/Tachidesk/docker_touchfile
	curl -s --create-dirs -L https://raw.githubusercontent.com/Suwayomi/docker-tachidesk/main/server.conf -o /home/suwayomi/.local/share/Tachidesk/server.conf;
fi
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
echo "log file location inside the container -> /home/suwayomi/.local/share/Tachidesk/logfile.log"
exec java -jar "/home/suwayomi/startup/tachidesk_latest.jar" > /home/suwayomi/.local/share/Tachidesk/logfile.log 2>&1;
