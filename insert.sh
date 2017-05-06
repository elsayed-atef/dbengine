#!/bin/bash
shopt -s extglob
clear
let index=0
let primfield=0
clear
echo Avaliable Database List are:
ls ~/scripts/data/
echo Enter Database Name to Select
read dbname
if [[ ! "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]]
then
        echo Wrong Database Name
        read a
        exit
fi
if [ ! -d ~/scripts/data/$dbname ]; then
    echo Database $dbname Does not Exist
    read a
    exit
fi
clear

echo Avaliable Tables in $dbname are
ls ~/scripts/data/$dbname/
echo Enter Table Name to Select
read tbname
if [[ ! "$tbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
    then
        echo Wrong Table Name Format
        read a
        exit
    fi
if [ ! -f ~/scripts/data/$dbname/$tbname ]; then
    echo Table $tbname Does not Exist
    read a
    exit
fi

echo "Well you want to insert into" Table $tbname in $dbname "Database"
primfield="$(sed -n "1p" ~/scripts/data/$dbname/.$tbname.meta)"
primfield=$(( $primfield+1 ))

sed -n '2p' ~/scripts/data/$dbname/.$tbname.meta 
sed -n 'p' ~/scripts/data/$dbname/$tbname | sort -t: -k"$[ $(sed -n '1p' ~/scripts/data/$dbname/.$tbname.meta) + 1 ]" 

echo  "Enter Value of Primary Key Colm in $tbname"
read val_prim

if [ -z $val_prim ]
then
    echo primary key cannot be null
    read a
    exit
fi

function check_primary {
case $val_prim in
+([[:alpha:]])) ret=2;;
+([[:digit:]])) ret=1;;
+([[:alnum:]])) ret=3;;
* ) ret=4;;
esac

if [ $ret -eq 4 ]
then
    echo Type not allowed
    read a
    exit
fi

myx="$(sed -n "/$val_prim/p" ~/scripts/data/$dbname/$tbname | cut -d: -f$primfield )" 


if [ "$val_prim" = "$myx" ] 
then
echo Prohipeted:Value $val of Primary Key is Repeated
read a
exit
fi

if [ $ret -ne `sed -n  '3p' ~/scripts/data/$dbname/.$tbname.meta |cut -d: -f$primfield ` ]; then
    echo Dataype Entered Mismatch Table Definition
    read a
    exit
fi

}

check_primary
 


for ct in `sed -n  '1p' ~/scripts/data/$dbname/.$tbname.meta  `
do
while [ $ct -ne 0 ] 
do
echo enter data of col: `sed -n  '2p' ~/scripts/data/$dbname/.$tbname.meta |cut -d: -f$(( $index+1 )) `
read val

function check_data {
case $val in
+([[:alpha:]])) ret=2;;
+([[:digit:]])) ret=1;;
+([[:alnum:]])) ret=3;;
* ) ret=4;;
esac

if [ $ret -eq 4 ]
then
    echo Type not allowed
    read a
    exit
fi


if [ $ret -ne `sed -n  '3p' ~/scripts/data/$dbname/.$tbname.meta |cut -d: -f$(( $index+1 )) ` ]; then
    echo Datatype Mismatch with Table Definition
    sed -i '$ d' ~/scripts/data/$dbname/$tbname
    read a
    exit
fi

}
check_data
 #touch   ~/scripts/data/$dbname/$tbname
    echo -n "$val:"   >>  ~/scripts/data/$dbname/$tbname
ct=$(( $ct-1 ))
index=$(( $index+1 ))
done

done
 echo -n "$val_prim"  >>  ~/scripts/data/$dbname/$tbname
echo >>  ~/scripts/data/$dbname/$tbname

sed -n '2p' ~/scripts/data/$dbname/.$tbname.meta 
sed -n 'p' ~/scripts/data/$dbname/$tbname | sort -t: -k"$[ $(sed -n '1p' ~/scripts/data/$dbname/.$tbname.meta) + 1 ]" 
read a



