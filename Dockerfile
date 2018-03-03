FROM scratch as build
COPY sshd_config /etc/sshd_config
COPY dock.sh /usr/bin/dock
COPY undock.sh /usr/bin/undock
COPY example.sh /usr/bin/example
COPY place.sh /usr/bin/place

FROM docker:stable
COPY --from=build / /
RUN apk --no-cache add openssh-server python3 && \
    python3 -m pip install docker-compose && \
    python3 -m pip uninstall -y pip setuptools && \
    ln -s /usr/local/bin/docker /usr/bin/docker && \
    rm /etc/ssh/sshd_config && \
    mkdir /keys && \
    chmod +x /usr/bin/dock /usr/bin/undock /usr/bin/example /usr/bin/place
VOLUME /etc/ssh
CMD ssh-keygen -A && /usr/sbin/sshd -f /etc/sshd_config -D
