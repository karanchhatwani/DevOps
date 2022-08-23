#!/usr/bin/bash

echo $@ &>/dev/null
for x in $@
do
	cat /etc/os-release | grep -i fedora &>/dev/null
	OS=`echo $?`
	if [ $OS -gt 0 ]
	then
		dpkg --get-selections | grep -w "$x" &>/dev/null
		ubuntu=`echo $?`
		if [ $ubuntu -eq 0 ]
		then
			echo "Software which you have entered is: $x"
			sleep 2 | echo "Installing software please wait...."
			sudo apt install $x -y &>/dev/null
			echo "Software installed successfully!"
		fi
	elif [ $OS -eq 0 ]
	then
		yum list installed | grep -w "$x" &>/dev/null
		redhat=`echo $?`
		if [ $redhat -eq 0 ]
		then
			echo "Software which you have entered is: $x"
			sleep 2 | echo "Installing software please wait...."
			sudo yum install $x -y &>/dev/null
			echo "Software installed successfully!"
		fi
	else
		echo "Software already installed!"
	fi
done
