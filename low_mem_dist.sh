#!/bin/bash

# This shell script provides information about used up low memory: allocated by page allocator, SLUB & Vmalloc

echo " "
echo "Distribution of Low Memory Allocations"
echo "--------------------------------------"
echo " "

cat /proc/meminfo | grep Low | awk '{print $1 $2 / 1024 "MB"}'
cat /proc/slabinfo | grep -v "<active_objs>" | awk '{ SUM += $3 * $4} END {print " "; print "Mem allocated by SLUB: " SUM / 1048576 "MB "}'
SLUB_total=`cat /proc/slabinfo | grep -v "<active_objs>" | awk '{ SUM += $3 * $4} END {print SUM }'`
cat /proc/vmallocinfo | awk '{ SUM += $2} END { print " "; print "Mem allocated by Vmalloc: " SUM / 1048576 "MB "}'
vmalloc_total=`cat /proc/vmallocinfo | awk '{ SUM += $2} END { print SUM }'`

echo " "

LowTotal=`cat /proc/meminfo | grep LowTotal | awk '{print $2 * 1024 }'`
k=`cat /proc/buddyinfo | grep " Normal " | awk '{ for(i = 1; i < NF; i++) { if (i > 4) { SUM += $i * (2 ** (i - 5))} } } END { print  SUM * 4096 }'`
page_mem=`expr $LowTotal - $k`
page_mem=`expr $page_mem - $SLUB_total`
page_mem=`expr $page_mem - $vmalloc_total`
page_mem=`expr $page_mem / 1048576`

echo "Memory allocated by page allocator directly in Normal/Low Zone: $page_mem MB"
buddy_mem=0
for j in `cat /proc/buddyinfo | awk '{print $4}'`
do
      k=`cat /proc/buddyinfo | grep " $j " | awk '{ for(i = 1; i < NF; i++) { if (i > 4) { SUM += $i * (2 ** (i - 5))} } } END { print  SUM }'`
      m=`expr $k / 256`
      echo "    Mem available in $j buddy zone : $m MB"
      buddy_mem=`expr $buddy_mem + $m`
done

echo "  Total Mem available in all buddy zones : $buddy_mem MB"

echo " "

