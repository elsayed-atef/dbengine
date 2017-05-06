clear
echo Avaliable Database List are :
ls ~/scripts/data/
echo Enter Database Name to Display
read dbname
echo $dbname
if [ ! -d ~/scripts/data/$dbname ]
then
    echo Database $dbname not Found
    read a
    exit
fi
if [[ ! "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
then
echo Wrong Database Format Entered
read a
exit
fi

clear

echo Avaliable Tables in $dbname are :
ls ~/scripts/data/$dbname/
echo Enter Table Name to Display
read tbname
if [ ! -f ~/scripts/data/$dbname/$tbname ]; then
    echo Table $tbname not found
    read a
    exit
fi
if [[ ! "$tbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
    then
        echo Wrong Table Format Entered
        read a
        exit
fi
clear
echo Enter Primary Key in Table $tbname to Display
read id
sed -n '2p' ~/scripts/data/$dbname/.$tbname.meta
sed -n "/.*:$id$/p" ~/scripts/data/$dbname/$tbname
read a