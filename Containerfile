FROM ubuntu:latest

# Update and install wget
RUN apt-get update && \
    apt-get install -y netcat-openbsd --no-install-recommends && \
    apt-get install -y libcap2-bin --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV TERM xterm-256color
ENV COLORTERM truecolor

COPY app.sh app/app.sh
RUN chmod +x app/app.sh

ENTRYPOINT ["app/app.sh"]
