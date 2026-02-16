#!/bin/bash

touch ~/.finances #Create file in user's home directory to store finance records in 

action=$1 #Stores first command line argument, which is the action
record=$2 #Stores second command line argument, which is the finance description

add () { #Appends record to finance file
echo $record >> ~/.finances 
}

remove (){ #Uses sed to remove record from finances
record=`echo $record | sed "s/^\(\"\)\(.*\)\1\$/\2/g" <<<"$record"`
sed -i "/$record/d" ~/.finances
}

view () { #Displays finances to terminal
cat ~/.finances
}

user-guide (){ #Lists all of the commands and actions to the terminal for the user
cat <<EOF
# User guide

## To add a transaction, enter "add" along with transaction description

## To remove a transaction, enter "remove" along with transaction description

## To view all transactions, enter "view"

## To clear all transactions, enter "clear" and enter confirm when prompted

## To pull up user guide again, enter "help"
EOF
}

clear () { #Deletes all finances
if [ "$1" = "Confirm" ]; then
        rm ~/.finances
	echo "Records cleared"
fi
}

#Case statement for all possible inputs the user enters
case $action in
	"add")
		if [[ -z "$record" ]]; then #If user didn't enter record description as command line argument
			read -p "Enter record description" record
			add
			echo "Record added"
		else
		add 
		echo "Record added"
		fi
	;;

	"remove")
		if [[ -z "$record" ]]; then #If user didn't enter record description as command line argument
                        read -p "Enter record description" record
                        remove
			echo "Record removed"
                else
                remove
		echo "Record removed"
                fi
	;;

	"view")
		view
	;;

	"clear")
		read -p "Enter "Confirm" to confirm clearing records" confirm #Asking user to confirm
		if [ "$confirm" = "Confirm" ]; then
			clear $confirm
		else
		echo "Clear not complete, records are still visible"
		fi
	;;

	"help")
		user-guide
	;;
	
	*)
		echo "Invalid argument"
		user-guide
	;;
esac
	