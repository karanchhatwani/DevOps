#!/usr/bin/bash

echo $@
echo $# &>/dev/null
number=`echo $#`
for x in $@
do
	cat /etc/os-release | grep -i fedora &>/dev/null
	OS=`echo $?`
	if [ $OS -gt 0 ]
	then
		apt list --installed | grep -w "$x" &>/dev/null
		ubuntu=`echo $?`
		if [ $ubuntu -gt 0 ]
		then
			echo "Software which you have entered is: $x"
			sleep 2 | echo "Installing software please wait...."
			sudo apt install $x -y &>/dev/null
			software=`echo $?`
			if [ $software -gt 0 ]
			then
				echo "Warning: This software does not exist, try another one!"
			else
				echo "Software installed successfully!"
				apt list --installed | tail -n $number
			fi

		else 
			echo "Software already installed!"
		fi
	elif [ $OS -eq 0 ]
	then
		yum list installed | grep -w "$x" &>/dev/null
		redhat=`echo $?`
		if [ $redhat -gt 0 ]
		then
			echo "Software which you have entered is: $x"
			sleep 2 | echo "Installing software please wait...."
			sudo yum install $x -y &>/dev/null
			echo "Software installed successfully!"
		fi
	elif [ $number -eq 0 ]
	then 
		echo "Please enter some software name"
	else
		echo "Software already installed!"
	fi
done
