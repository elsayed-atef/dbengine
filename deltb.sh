#!/bin/bash
clear
echo Avaliable Database List are:
ls ~/scripts/data/
echo Enter Database name to Select
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

echo List of Tables in $dbname are:
ls ~/scripts/data/$dbname/
echo Enter Table Name to Delete
read tbname
if [[ ! "$tbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
    then
        echo Wrong Naming Formate
        read a
        exit
    fi
if [ ! -f ~/scripts/data/$dbname/$tbname ]; then
    echo Table $tbname Does not Exit
    read a
    exit
fi

rm ~/scripts/data/$dbname/$tbname
rm ~/scripts/data/$dbname/.$tbname.meta

echo table $tbname in $dbname was deleted
read a
