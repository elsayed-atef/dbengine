#!/bin/bash
clear
echo Available Data Base Are:
ls ~/scripts/data
echo Enter Database Name To Create
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
for var in `ls ~/scripts/data/`
do
if [ $var = $dbname ]
then
echo Dabase Name Selected Already Exist
read a
exit
fi
done
mkdir ~/scripts/data/$dbname;
echo Database Created Succefully
read a

