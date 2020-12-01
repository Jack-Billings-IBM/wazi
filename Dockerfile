       FROM registry.access.redhat.com/ubi8/ubi:latest
        ARG home=/home/jack
        RUN yum -y update && \
            yum -y install openssh-server \
            openssh-clients && \
            /usr/bin/ssh-keygen -A && \
            groupadd user && \
            useradd -ms /bin/bash -g user jack && \
            echo 'jack:passw0rd' | chpasswd && \
            mkdir $home/.ssh && \
            touch $home/.ssh/authorized_keys && \
            chown jack:user $home/.ssh/authorized_keys && \
            chmod 600 $home/.ssh/authorized_keys
        EXPOSE 24
        CMD /usr/sbin/sshd && sleep infinity
