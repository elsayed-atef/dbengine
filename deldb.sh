#!/bin/bash
clear
echo Available Database List are:
ls ~/scripts/data/
echo Enter Database Name to Select
read dbname
if [[ ! "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
then
        echo Wrong Name Selected
        read a
        exit
fi
if [ ! -d ~/scripts/data/$dbname ]; then
    echo Database $dbname does not Exist
    read a
    exit
fi

rm -R ~/scripts/data/$dbname
echo Database $dbname Was Deleted Successfuly
read a

