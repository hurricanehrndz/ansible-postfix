FROM ubuntu:16.04

ENV DEBIAN_FRONTEND="noninteractive" container="docker"

RUN apt-get update \
 && apt-get install -y \
	curl \
	lsb-release \
	net-tools \
	openssh-server \
	sudo \
	systemd \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && if ! getent passwd <%= @username %>; then \
      useradd -d /home/<%= @username %> -m -s /bin/bash -p '*' <%= @username %>; \
    fi \
 && echo "<%= @username %> ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
 && echo "Defaults !requiretty" >> /etc/sudoers \
 && mkdir -p /home/<%= @username %>/.ssh \
 && chown -R <%= @username %> /home/<%= @username %>/.ssh \
 && chmod 0700 /home/<%= @username %>/.ssh \
 && echo '<%= IO.read(@public_key).strip %>' >> /home/<%= @username %>/.ssh/authorized_keys \
 && chown <%= @username %> /home/<%= @username %>/.ssh/authorized_keys \
 && chmod 0600 /home/<%= @username %>/.ssh/authorized_keys \
 && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen \
 && cd /lib/systemd/system/sysinit.target.wants/; ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 \
 && rm -f /lib/systemd/system/multi-user.target.wants/* \
 && rm -f /etc/systemd/system/*.wants/* \
 && rm -f /lib/systemd/system/local-fs.target.wants/* \
 && rm -f /lib/systemd/system/sockets.target.wants/*udev* \
 && rm -f /lib/systemd/system/sockets.target.wants/*initctl* \
 && rm -f /lib/systemd/system/basic.target.wants/* \
 && rm -f /lib/systemd/system/anaconda.target.wants/*  \
 && rm -f /lib/systemd/system/plymouth* \
 && rm -f /lib/systemd/system/systemd-update-utmp* \
 && sed -ri 's/^#?UsePAM\s+.*/UsePAM no/' /etc/ssh/sshd_config \
 && sed -ri 's/^#?PubkeyAuthentication\s+.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
 && sed -ri 's/^#?UsePrivilegeSeparation\s+.*/UsePrivilegeSeparation no/' /etc/ssh/sshd_config \
 && echo "UseDNS=no" >> /etc/ssh/sshd_config \
 && systemctl set-default multi-user.target \
 && systemctl preset ssh

EXPOSE 22

VOLUME [ "/sys/fs/cgroup" ]
