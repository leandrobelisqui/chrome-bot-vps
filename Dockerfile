FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  wget curl unzip xvfb x11vnc fluxbox supervisor \
  fonts-liberation libappindicator3-1 libasound2 \
  libatk-bridge2.0-0 libatk1.0-0 libcups2 libdbus-1-3 \
  libgdk-pixbuf2.0-0 libnspr4 libnss3 libxss1 \
  libxtst6 xdg-utils gnupg ca-certificates

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list' && \
  apt-get update && apt-get install -y google-chrome-stable

COPY extensao /opt/extensao
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5900

CMD ["/usr/bin/supervisord"]