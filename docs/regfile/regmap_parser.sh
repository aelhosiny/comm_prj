#/bin/sh

sheet=$1
rm -f interface.txt


xls2csv $sheet > tmp.csv
length=`cat tmp.csv | wc -l`
length=`expr $length - 1`
#echo $length
tail -n $length tmp.csv > regmap.csv

IFS="
"

j=1
for i in `cat regmap.csv`
do

   nullcell=0
   nregs=0
   reglist=""
   
   if [ $j -eq 1 ]
   then
      reg_row=$i
      address=`echo $reg_row | awk -F',' '{print $1}'`
   elif [ $j -eq 2 ]
   then
      defaults=$i
   elif [ $j -eq 3 ]
   then
      types=$i   
   fi
   
   
   
   if [ $j -eq 3 ]
   then
      
      for k in `seq 2 9`
      do
         extreg=`echo $reg_row | grep -c '\['`
         n=`echo $reg_row | awk -F',' '{print $'$k'}' | grep -c "\""`
         if [ $n -eq 0 ]
         then
            nullcell=`expr $nullcell + 1`
         else
            nregs=`expr $nregs + 1`
         fi
         
         regtype=`echo $types | awk -F',' '{print $'$k'}' | sed 's_\"__g'`
         
         if [ $extreg -eq 0 ] && [ $nregs -gt 1 ] && [ "$regtype" != "x" ] ;
         then
            regname=`echo $reg_row | awk -F',' '{print $'$k'}' | sed 's_\"__g'`
            regwidth=1
            regdefault=`echo $defaults | awk -F',' '{print $'$k'}' | sed 's_\"__g'`
            regindex=`expr 9 - $k`
            echo "$regname,$regwidth,$regindex,$regtype,$regdefault">> interface.txt 
         fi
      done
      
   fi
   
   if [ $j -lt 3 ] 
   then   
      j=`expr $j + 1`
   else
      j=1
   fi
done








