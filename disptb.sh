clear
echo Avaliable Database List are:
ls ~/scripts/data/
echo Enter Database Name to Display
read dbname
echo $dbname
if [ ! -d ~/scripts/data/$dbname ]
then
    echo Database $dbname Not Found
    read a
    exit
fi
if [[ ! "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
then
echo Wrong Database Naming
read a
exit
fi

clear

echo Avaliable Tables in $dbname are :
ls ~/scripts/data/$dbname/
echo Enter table name to Display
read tbname
if [ ! -f ~/scripts/data/$dbname/$tbname ]; then
    echo Table $tbname Select does not Exist
    read a
    exit
fi
if [[ ! "$tbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
    then
        echo Wrong Table Naming
        read a
        exit
fi
clear
sed -n '2p' ~/scripts/data/$dbname/.$tbname.meta 
sed -n 'p' ~/scripts/data/$dbname/$tbname | sort -t: -k"$[ $(sed -n '1p' ~/scripts/data/$dbname/.$tbname.meta) + 1 ]" 
read a