#/bin/sh

sheet=$1
rm -f interface.txt
rm -f default.txt

xls2csv $sheet > tmp.csv
length=`cat tmp.csv | wc -l`
length=`expr $length - 1`
#echo $length
tail -n $length tmp.csv > regmap.csv

IFS="
"

j=1
l=1

for i in `cat regmap.csv`
do

   nullcell_count=0
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
         ## detect multi-bit registers
         extreg=`echo $reg_row | grep -c '\['`
         
         ## get number of null cells, number of registers
         nullcell=`echo $reg_row | awk -F',' '{print $'$k'}' | grep -c "\""`
         if [ $nullcell -eq 0 ]
         then
            nullcell_count=`expr $nullcell_count + 1`
         else
            nregs=`expr $nregs + 1`
         fi
         ##########################################################
         
         ## get register type and default value
         regtype=`echo $types | awk -F',' '{print $'$k'}' | sed 's_\"__g'`
         regdefault=`echo $defaults | awk -F',' '{print $'$k'}' | sed 's_\"__g'`
         
         ## extract regfile interface
         if [ $extreg -eq 0 ] && [ $nregs -gt 1 ] && [ "$regtype" != "x" ] ;
         then
            regname=`echo $reg_row | awk -F',' '{print $'$k'}' | sed 's_\"__g'`
            regwidth=1
            regindex=`expr 9 - $k`
            echo "$regname,$regwidth,$regindex,$regtype,$regdefault">> interface.txt
         elif [ $extreg -eq 1 ] && [ "$regtype" != "x" ] && [ $nullcell -eq 0 ];
         then
            regname=`echo $reg_row | awk -F',' '{print $'$k'}' | sed 's_\"__g' | awk -F"[" '{print $1}'`
            regwidth=`echo $reg_row | awk -F',' '{print $'$k'}' | sed 's_\"__g' | awk -F"[" '{print $2}' | awk -F":" '{print $1}'`
            regindex=`expr 9 - $k`
         fi
         ##########################################################
         ## extract default values for each register space
         if [ "$regtype" = "w" ]
         then
            add_dflt="$add_dflt$regdefault"
         else
            zero=0
            add_dflt="$add_dflt$zero"
         fi
      done ## for k in `seq 2 9`
      
      echo "$address,$add_dflt" >> default.txt
      add_dflt=""
   fi ## if [ $j -eq 3 ]
   
   if [ $j -lt 3 ] 
   then   
      j=`expr $j + 1`
   else
      j=1
   fi
   l=`expr $l + 1`
done ## for i in `cat regmap.csv`








