#!/usr/bin/bash

echo $@ &>/dev/null
echo $# &>/dev/null
for x in $@
do 
	cat /etc/passwd | grep -i $x &>/dev/null
	status=`echo $?`
	cat /etc/os-release | grep -i fedora &>/dev/null
	OS=`echo $?`
	if [ $status -gt 0 ]
	then
		if [ $OS -eq 0 ]
		then 
			echo "Username which you have entered is: $x and it will be now added in the system"
			sleep 2 | echo "Adding user please wait...."
			sudo useradd -p $(openssl passwd -1 Shell@098@) $x
			echo "User added successfully!"
			elif [ $OS -gt 0 ]
			then
				echo "Username which you have entered is: $x and it will be now added in the system"
				sleep 2 | echo "Adding user please wait...."
				sudo useradd -m -p $(openssl passwd -1 Shell@098@) $x
				echo "User added successfully"
		fi
	else 
		echo "Sab kuch dhundhala hai"
	fi
done
