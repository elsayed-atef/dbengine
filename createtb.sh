#!/bin/bash
clear
echo Available Data Base Are:
ls ~/scripts/data/
echo Enter Database Name to Enter a table in it
read dbname
if [[ ! "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
then
        echo Error in Naming Format of Database 
        echo Must start with letter 
        echo Contain no spaces 
        echo Only AlphaNumeric is Allowed
        read a
        exit
fi
if [ ! -d ~/scripts/data/$dbname ]; then
    echo Database You Selected Do Not Exist
    read a
    exit
else
    clear
    echo List of Tables in $dbname are :
    ls ~/scripts/data/$dbname 
    echo Enter New Table Name To Create
    read tbname
    if [[ ! "$tbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
    then
        echo Error in Naming Format of Table 
        echo Must start with letter 
        echo Contain no spaces 
        echo Only AlphaNumeric is Allowed
        read a
        exit
    fi
    for  var in  `ls ~/scripts/data/$dbname/`
    do
       if [ $var = $tbname ]
       then
         echo Table $tbname Selected is Already In $dbname
         read a
         exit
       fi
    done
fi

./createtbdata.sh $dbname $tbname
