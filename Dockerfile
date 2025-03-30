FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

# Instala dependências e pacotes necessários
RUN apt-get update && apt-get install -y \
    wget curl unzip gnupg software-properties-common \
    xvfb x11vnc fluxbox supervisor \
    fonts-liberation libappindicator3-1 libasound2 \
    libatk-bridge2.0-0 libatk1.0-0 libcups2 libdbus-1-3 \
    libgdk-pixbuf2.0-0 libnspr4 libnss3 libxss1 \
    libxtst6 xdg-utils tzdata ca-certificates

# Adiciona o repositório do Google Chrome (forma atualizada)
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable

# Define o timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copia a configuração do supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5900

CMD ["/usr/bin/supervisord"]
