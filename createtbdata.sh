#!/bin/bash
function join_by {
    local IFS="$1"; 
    shift; 
    echo "$*"; 
}
dbname=$1
tbname=$2
clear
echo Enter Number of Columns in $tbname
   read colms
                
   if [[ ! "$colms" =~  ^[1-9][0-9]*$  ]]
   then
    echo Wrong Please Enter a Number
    read a
    exit
   fi
echo Enter Name of Primary Key Column
read prime
            
if [[ ! "$prime" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
then
  echo Error in Naming Format of Column 
  echo Must start with letter 
  echo Contain no spaces 
  echo Only AlphaNumeric is Allowed
  read a
  exit
fi
            
echo "Enter Primary key Data type" 
echo "[1]   for number"
echo "[2]   for letters"
echo "[3]   for alpha numerical"
read  primtype

if [ $primtype = "1" ] || [   $primtype = "2" ] || [  $primtype = "3" ]  
then
   typeset -i colms
                
   clear 
   

   typeset -i count

   count=0
   clear
	colms=colms-1
   while [ $count -lt $colms ]
   do
     clear
     echo Enter Name of colm $(( $count+2 ))
     read colmname
                    
     if [[ ! "$colmname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
     then
        echo Error in Naming Format of Column 
        echo Must start with letter 
        echo Contain no spaces 
        echo Only AlphaNumeric is Allowed
       read a
       exit
     fi
                    
     for  var in  `echo ${colmn[@]} $prime`
     do
       if [ $var = $colmname ]
       then
         echo Column $colmname already Exist
         read a
         exit
       fi
     done
                    
     colmn[$count]=$colmname;
                        
     echo Enter Column Key Data Type 
     echo [1]   for number
     echo [2]   for letters
     echo [3]   for alpha numerical
     read  colmtype
                        
     if [ $colmtype = "1" ] || [ $colmtype = "2" ] || [ $colmtype = "3" ] 
     then
        colmt[$count]=$colmtype
        count=count+1
     else
        echo Wrong Data Type Entered
        read a
        exit
     fi
                        
   done
                
   colmn[$colms]=$prime
   colmt[$colms]=$primtype
            
   touch ~/scripts/data/$dbname/$tbname
   touch   ~/scripts/data/$dbname/.$tbname.meta
   join_by : $colms          >  ~/scripts/data/$dbname/.$tbname.meta
   join_by : ${colmn[@]}     >> ~/scripts/data/$dbname/.$tbname.meta
   join_by : ${colmt[@]}     >> ~/scripts/data/$dbname/.$tbname.meta
                
   if [ $? -eq 0 ]
	then
	echo Table $tbname  created in $dbname Database
	echo "Table Structure Created Successfully"
	read a
        exit
   fi             
                
else
  echo Wrong Data Type Selected
  read a
  exit
fi
