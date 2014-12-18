
#!/bin/bash

cat /proc/meminfo | grep Low | awk '{print $1 $2 / 1024 "MB"}'
cat /proc/slabinfo | grep -v "<active_objs>" | awk '{ SUM += $2 * $4} END {print " "; print "Mem used in SLUB: " SUM / 1048576 "MB    Total"}'
cat /proc/vmallocinfo | awk '{ SUM += $2} END { print " "; print "Mem used in Vmalloc: " SUM / 1048576 "MB    Total"}'

buddy_mem=0
for j in `cat /proc/buddyinfo | awk '{print $4}'`
do
      k=`cat /proc/buddyinfo | grep " $j " | awk '{ for(i = 1; i < NF; i++) { if (i > 4) { SUM += $i * (2 ** (i - 5))} } } END { print  SUM }'`
      m=`expr $k / 256`
      echo "Mem available in $j buddy zone : $m MB"
      buddy_mem=`expr $buddy_mem + $m`
done

echo "Mem available in all buddy zones : $buddy_mem MB"

#cat /proc/meminfo | grep Low | awk '{print $1 $2 / 1024 "MB"}'; cat /proc/slabinfo | grep -v "<active_objs>" | awk '{ SUM += $2 * $4} END {print " "; print "Mem used in SLUB: " SUM / 1048576 "MB    Total"}' ; cat /proc/vmallocinfo | awk '{ SUM += $2} END { print " "; print "Mem used in Vmalloc: " SUM / 1048576 "MB    Total"}'
