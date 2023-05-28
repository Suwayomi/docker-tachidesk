FROM eclipse-temurin:11-jre-focal

RUN apt update && apt install -y --no-install-recommends \
				xvfb \
				xauth \
				x11vnc \
				x11-utils \
				x11-xserver-utils \
				novnc \
                supervisor \
				libglib2.0-0 \
				libnss3 \
				libnspr4 \
				libatk1.0-0 \
				libatk-bridge2.0-0 \
				libcups2 \
				libdrm2 \
				libdbus-1-3 \
				libatspi2.0-0 \
				libx11-6 \
				libxcomposite1 \
				libxdamage1 \
				libxext6 \
				libxfixes3 \
				libxrandr2 \
				libgbm1 \
				libxkbcommon0 \
				libxcb1 \
				libpango-1.0-0 \
				libcairo2 \
				libasound2

RUN groupadd --gid 1000 suwayomi && useradd  --uid 1000 --gid suwayomi --no-log-init suwayomi;

RUN mkdir -p /home/suwayomi && chown -R suwayomi:suwayomi /home/suwayomi

RUN mkdir -p /Xauthority && chown -R suwayomi:suwayomi /Xauthority

VOLUME /Xauthority

USER suwayomi

WORKDIR /home/suwayomi

RUN curl -s --create-dirs -L https://raw.githubusercontent.com/suwayomi/docker-tachidesk/main/scripts/startup_script.sh -o /home/suwayomi/startup/startup_script.sh

RUN curl -L $(curl -s https://api.github.com/repos/suwayomi/tachidesk-server/releases/latest | grep -o "https.*jar") -o /home/suwayomi/startup/tachidesk_latest.jar

RUN curl -s --create-dirs -L https://raw.githubusercontent.com/suwayomi/docker-tachidesk/main/supervisord.conf -o /home/suwayomi/startup/supervisord.conf

RUN curl -s --create-dirs -L https://raw.githubusercontent.com/suwayomi/docker-tachidesk/main/conf.d/tachidesk.conf -o /home/suwayomi/startup/conf.d/tachidesk.conf
RUN curl -s --create-dirs -L https://raw.githubusercontent.com/suwayomi/docker-tachidesk/main/conf.d/websockify.conf -o /home/suwayomi/startup/conf.d/websockify.conf
RUN curl -s --create-dirs -L https://raw.githubusercontent.com/suwayomi/docker-tachidesk/main/conf.d/x11vnc.conf -o /home/suwayomi/startup/conf.d/x11vnc.conf
RUN curl -s --create-dirs -L https://raw.githubusercontent.com/suwayomi/docker-tachidesk/main/conf.d/xvfb.conf -o /home/suwayomi/startup/conf.d/xvfb.conf

# start x11vnc and expose its port
ENV DISPLAY :0.0
# vnv server
EXPOSE 5900
# novnc
EXPOSE 5800
# Tachidesk
EXPOSE 4567

CMD ["/bin/sh", "/home/suwayomi/startup/startup_script.sh"]
