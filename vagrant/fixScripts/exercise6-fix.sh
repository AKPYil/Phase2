#!/bin/bash
#add fix to exercise6-fix here
# bash -x /vagrant/fixScripts/exercise6-fix.sh /vagrant/Vagrantfile /etc/crontab /tmp/

if [[ $# < 2 ]];then
	echo "You need to pass minimum of 2 parameters"
	exit 1
fi

remote_path=$BASH_ARGV

if [[ "$HOSTNAME" == "server1" ]]
then
    host="server2"
	command="scp"
	user=$USER
else
    host="server1"
	user="root"
	command="sshpass -p vagrant scp"
	sudo apt-get install sshpass
fi

for var in ${*%${!#}}
do
	if [[ ! -e $var ]]; then
		echo "Passed file path: '"$var"' does not exist"
		exit 1
	fi
	if [[ ! -d $remote_path ]]; then
		echo "file output is not defined"
		exit 1
	fi
	
	$command $var $user@$host:$remote_path
	
	if [[ $? != 0 ]]; then
		echo "*** Error: While copying file '$var' to directory '$remote_path'"
	fi
	for file in "$var"*
		do
			if [[ -f $file ]]
			then
				((size+=$(stat -c%s "$file")))
			fi
		done
done
echo "$size"