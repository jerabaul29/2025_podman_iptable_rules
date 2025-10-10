FROM ubuntu:latest

# Update and install wget
RUN apt-get update && \
    apt-get install -y netcat-openbsd --no-install-recommends && \
    apt-get install -y libcap2-bin --no-install-recommends && \
    apt-get install -y iptables --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV TERM xterm-256color
ENV COLORTERM truecolor

COPY app.sh app/app.sh
RUN chmod +x app/app.sh

# Add iptables rules to deny all incoming and outgoing traffic
# this will not work in rootless mode (which is the expected and intended behavior)
# > iptables v1.8.10 (nf_tables): Could not fetch rule set generation id: Permission denied (you must be root)
# RUN iptables -P INPUT DROP && \
#     iptables -P OUTPUT DROP && \
#     iptables -P FORWARD DROP

ENTRYPOINT ["app/app.sh"]
