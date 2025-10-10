FROM ubuntu:latest

# Update and install wget
RUN apt-get update && \
    apt-get install -y netcat-openbsd --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY app.sh app/app.sh
RUN chmod +x app/app.sh

ENTRYPOINT ["app/app.sh"]
