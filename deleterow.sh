#!/bin/bash
shopt -s extglob
clear
let primfield=0
echo Avaliable Database to Select are:
ls ~/scripts/data/
echo Enter Database Name to Select
read dbname
if [[ ! "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]]
then
        echo Wrong Database Name Entered
        read a
        exit
fi
if [ ! -d ~/scripts/data/$dbname ]; then
    echo Database $dbname Selected Does Not Exist
    read a
    exit
fi
clear

echo Avaliable Tables to Delete from  $dbname are: 
ls ~/scripts/data/$dbname/
echo Enter Table Name To Delete
read tbname
if [[ ! "$tbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
    then
        echo error Naming Format
        read a
        exit
    fi
if [ ! -f ~/scripts/data/$dbname/$tbname ]; then
    echo Table $tbname Does not Exist
    read a
    exit
fi
clear
sed -n '2p' ~/scripts/data/$dbname/.$tbname.meta 
sed -n 'p' ~/scripts/data/$dbname/$tbname | sort -t: -k"$[ $(sed -n '1p' ~/scripts/data/$dbname/.$tbname.meta) + 1 ]" 

echo  Enter Value of Primary Key to Delete
read val_prim
primfield="$(sed -n "1p" ~/scripts/data/$dbname/.$tbname.meta)"
primfield=$(( $primfield+1 ))
myx="$(sed -n "/.*:$val_prim$/p" ~/scripts/data/$dbname/$tbname | cut -d: -f$primfield )" 


if [ "$val_prim" != "$myx" ] 
then

echo Primary Key Select $val_prim Does not Exist
read a
exit
else
sed -i "/.*:$val_prim$/d" ~/scripts/data/$dbname/$tbname 2>/dev/null
sed -i "/$val_prim$/d" ~/scripts/data/$dbname/$tbname 2>/dev/null
fi

echo "Well you deleted " $dbname "database table name " $tbname "row identified by" $val_prim
read a






