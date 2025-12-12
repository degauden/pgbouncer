FROM cern/cs9-base:latest

#pgBouncer
RUN yum -y install pgbouncer

RUN yum install -y sudo vim

# Create dedicated non-root user with proper privileges
RUN useradd -m -G wheel docker && \
    echo "docker ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/docker && \
    chmod 0440 /etc/sudoers.d/docker && \
    mkdir -p /etc/pgbouncer /var/run/pgbouncer /var/log/pgbouncer && \
    chown -R docker:docker /etc/pgbouncer /var/run/pgbouncer /var/log/pgbouncer && \
    chmod -R 775 /etc/pgbouncer /var/run/pgbouncer /var/log/pgbouncer


USER docker

CMD pgbouncer -d /etc/pgbouncer/pgbouncer.ini; sleep infinity
