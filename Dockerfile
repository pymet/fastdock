FROM docker:18.02
RUN apk --no-cache add openssh-server python3
RUN python3 -m pip install docker-compose
RUN ln -s /usr/local/bin/docker /usr/bin/docker
RUN mkdir /keys
RUN rm /etc/ssh/sshd_config
COPY sshd_config /etc/sshd_config
COPY dock.sh /usr/bin/dock
COPY undock.sh /usr/bin/undock
COPY example.sh /usr/bin/example
COPY place.sh /usr/bin/place
RUN chmod +x /usr/bin/dock /usr/bin/undock /usr/bin/example /usr/bin/place
VOLUME /etc/ssh
CMD ssh-keygen -A && /usr/sbin/sshd -f /etc/sshd_config -D
