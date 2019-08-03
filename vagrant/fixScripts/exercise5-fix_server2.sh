#!/bin/bash
#add fix to exercise5-server2 here

cat << 'SSHEOF' > /etc/ssh/ssh_config
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
SSHEOF

cat << 'SSHEOF' > /etc/ssh/sshd_config
AuthorizedKeysFile .ssh/authorized_keys /etc/ssh/authorized_keys
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM no
SSHEOF

cat /vagrant/server1.pub >> /root/.ssh/authorized_keys
cat /vagrant/server1_vagrant.pub >> /root/.ssh/authorized_keys
cat /vagrant/server1.pub >> /home/vagrant/.ssh/authorized_keys
cat /vagrant/server1_vagrant.pub >> /home/vagrant/.ssh/authorized_keys
cat /vagrant/server1.pub >> /home/ubuntu/.ssh/authorized_keys
cat /vagrant/server1_vagrant.pub >> /home/ubuntu/.ssh/authorized_keys