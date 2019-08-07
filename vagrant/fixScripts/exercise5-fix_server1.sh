#!/bin/bash
#add fix to exercise5-server1 here

ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa

ssh-keygen -t rsa -N "" -f /home/vagrant/.ssh/id_rsa
chown -R vagrant:vagrant /home/vagrant/.ssh/

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

cp /root/.ssh/id_rsa.pub /vagrant/server1.pub
cp /home/vagrant/.ssh/id_rsa.pub /vagrant/server1_vagrant.pub
cat /vagrant/server1.pub >> /root/.ssh/authorized_keys
cat /vagrant/server1_vagrant.pub >> /root/.ssh/authorized_keys
cat /vagrant/server1.pub >> /home/vagrant/.ssh/authorized_keys
cat /vagrant/server1_vagrant.pub >> /home/vagrant/.ssh/authorized_keys


