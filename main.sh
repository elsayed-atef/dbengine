#!/bin/bash
clear;
while [ true ]
do
clear;
echo "***************************************************"
echo "*               Welcome To DataBase Engine        *"
echo "*  created by Ahmed Essam && El-sayed Atef        *"
echo "*              Bash Shell  script                 *"
echo "***************************************************"
#display menu insert update delete
#inorder to insert required unique id then content
PS3="Enter Your Selection:" #to set prompt in select menu

select choice in "Create New Database" "Create New Table" "Insert Row in Table" "Update Existing Row in Table" "Delete row" "Display Row" "Delete table" "Delete Database" "Display Table" "Exit"
do

case $REPLY in
1 ) ./createdb.sh ;break ;;
2 ) ./createtb.sh  ;break;;
3 ) ./insert.sh   ;break ;; 
4 ) ./modifyrow.sh ;break;;
5 ) ./deleterow.sh  ;break  ;;
6 ) ./disprow.sh ; break;;
7 ) ./deltb.sh  ;break;;
8 ) ./deldb.sh  ;break;;
9 ) ./disptb.sh ;break;;
10 ) exit ;;
* ) echo "invalid option" ;break ;;
esac
done 
done
