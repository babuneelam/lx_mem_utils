lx_mem_utils
============

Shell scripts to get useful information about linux memory

Sample Output:

root@babu-VirtualBox:~/tools# ./mem_dist.sh 

Distribution of Low Memory Allocations
--------------------------------------
 
LowTotal:792.711MB

LowFree:108.691MB
 
Mem allocated by SLUB: 89.2992MB 
 
Mem allocated by Vmalloc: 21.8008MB 
 
Memory allocated by page allocator directly in Normal/Low Zone: 584 MB

	 Mem available in DMA buddy zone : 6 MB
	 
	 Mem available in Normal buddy zone : 97 MB
	 
	 Mem available in HighMem buddy zone : 33 MB
	 
	 Total Mem available in all buddy zones : 136 MB
 
 
root@babu-VirtualBox:~/tools#
 
