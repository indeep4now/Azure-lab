#!/bin/bash
#Create a folder for data and text files
~/backup/{freemem,diskuse,openlist,freedisk}
#Free memory output to a free_mem.txt file
free -h > ~/backup/freemem/free_mem.txt
#Disk usage output to a disk_usage.txt file
du -h > ~/backup/diskuse/disk_usage.txt
#List open files to a open_list.txt file
lsof > ~/backup/openlist/open_list.txt
#Free disk space to a free_disk.txt file
df -h > ~/backup/freedisk/free_disk.txt