#!/bin/bash
shopt -s extglob
clear
let primfield=0
let i=1
declare -a valarr
clear
ls ~/scripts/data/
echo Avaliable Database List are: 
read dbname
if [[ ! "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]]
then
        echo Wrong Database Name Format
        read a
        exit
fi
if [ ! -d ~/scripts/data/$dbname ]; then
    echo Database $dbname Does not Exit
    read a
    exit
fi
clear

echo Avaliable Tables in $dbname Database are:
ls ~/scripts/data/$dbname/
echo Enter Table Name  To Select
read tbname

if [[ ! "$tbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
    then
        echo Wrong Naming Format
        read a
        exit
fi

if [ ! -f ~/scripts/data/$dbname/$tbname ]; then
    echo Table $tbname doesnt Exist
    read a
    exit
fi

sed -n '2p' ~/scripts/data/$dbname/.$tbname.meta 
sed -n 'p' ~/scripts/data/$dbname/$tbname | sort -t: -k"$[ $(sed -n '1p' ~/scripts/data/$dbname/.$tbname.meta) + 1 ]" 

echo  "Enter the value of primary key of the row you want to modify"
read val_prim_old

if [ -z $val_prim_old  ]
then
    echo Primary Key Cannot be Null
    read a
    exit
fi

primfield="$(sed -n "1p" ~/scripts/data/$dbname/.$tbname.meta)"
primfield=$(( $primfield+1 ))
myx="$(sed -n "/(.*:$val_prim_old$)/p" ~/scripts/data/$dbname/$tbname | cut -d: -f$primfield )" 

if [ -z $myx ]
then
    myx="$(sed -n "/$val_prim_old$/p" ~/scripts/data/$dbname/$tbname | cut -d: -f$primfield )" 
    sed -n '2p' ~/scripts/data/$dbname/.$tbname.meta 
    sed -n 'p' ~/scripts/data/$dbname/$tbname | sort -t: -k"$[ $(sed -n '1p' ~/scripts/data/$dbname/.$tbname.meta) + 1 ]" 
  #  sed -i "/$val_prim_old$/d" ~/scripts/data/$dbname/$tbname

    if [ "$val_prim_old" != "$myx" ] 
    then
        echo Primary Key value $val_prim_old Does not Exist
        read a
        exit
    fi
else
myx="$(sed -n "/(.*:$val_prim_old$)/p" ~/scripts/data/$dbname/$tbname | cut -d: -f$primfield )"
    sed -n '2p' ~/scripts/data/$dbname/.$tbname.meta 
    sed -n 'p' ~/scripts/data/$dbname/$tbname | sort -t: -k"$[ $(sed -n '1p' ~/scripts/data/$dbname/.$tbname.meta) + 1 ]" 
   # sed -i "/.*:$val_prim_old$/d" ~/scripts/data/$dbname/$tbname

    if [ "$val_prim_old" != "$myx" ] 
    then
        echo Primary Key value $val_prim_old Does not Exist
        read a
        exit
    fi
fi




echo  "Enter the NEW Value of Primary Key"
read val_prim

if [ -z $val_prim  ]
then
    echo Primary Key Cannot be Null
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



if [ $ret -ne `sed -n  '3p' ~/scripts/data/$dbname/.$tbname.meta |cut -d: -f$primfield ` ]; then
    echo DataType Mismatch with Table Definition
    read a
    exit
fi

}

check_primary
myx="$(sed -n "/.*:$val_prim$/p" ~/scripts/data/$dbname/$tbname | cut -d: -f$primfield )" 

if [ "$val_prim" = "$val_prim_old" ];  then  break 2>/dev/null;

elif [ "$val_prim" = "$myx" ] 
then


#else
echo Prohipeted:Primary Key $val_prim value Cannot be Repeated
read a
exit

#else
 #sed -i "/$val_prim$/d" ~/scripts/data/$dbname/$tbname 2>/dev/null
 #sed -i "/.*:$val_prim$/d" ~/scripts/data/$dbname/$tbname 2>/dev/null

fi



for ct in `sed -n  '1p' ~/scripts/data/$dbname/.$tbname.meta  `
do
while [ $ct -ne 0 ] 
do
echo Enter Data of column: `sed -n  '2p' ~/scripts/data/$dbname/.$tbname.meta |cut -d: -f$(( $index+1 )) `
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
    read a
    exit
fi

}
check_data
 #touch   ~/scripts/data/$dbname/$tbname
valarr[$(( $index+1 ))]="$val:"
    #echo -n "$val:"   >>  ~/scripts/data/$dbname/$tbname
ct=$(( $ct-1 ))
index=$(( $index+1 ))

done

done





sed -i "/$val_prim$/d" ~/scripts/data/$dbname/$tbname 2>/dev/null
sed -i "/.*:$val_prim$/d" ~/scripts/data/$dbname/$tbname 2>/dev/null

echo -n "${valarr[@]}" >>  ~/scripts/data/$dbname/$tbname

 echo -n "$val_prim"  >>  ~/scripts/data/$dbname/$tbname
 echo >>  ~/scripts/data/$dbname/$tbname
 clear
 echo table $tbname in $dbname been modified
 sed -n '2p' ~/scripts/data/$dbname/.$tbname.meta 
 sed -n 'p' ~/scripts/data/$dbname/$tbname | sort -t: -k"$[ $(sed -n '1p' ~/scripts/data/$dbname/.$tbname.meta) + 1 ]" 
 read a
