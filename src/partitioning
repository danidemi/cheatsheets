## Ways of Splitting Space On Disks

* Disk
  * Volumes/Drives
    * Partitions
      * Sectors

* Master Boot Record (MBR)
  * Old way of partitioning disks.

* GUID Partition Table (GPT)
  * Moder way for partitioning disks.
  
## GPT

* GUID Partition Table (GPT)
* GPT partition
  * unique identification GUID (identify the single partition)
  * partition GUID (identify the type of partition)
  * partition content type
  * 16-byte partition type GUID: basic disk / dynamnic disk
  * Protective MBR: to act nicely with GPT-unaware old software
  
UEFI systems require an EFI System Partition.  
Extensible Firmware Interface System Partition (ESP)
* Required GPT partition (with NTLDR, HAL, Boot.txt, and other files that are needed to boot the system)
* Used for Windows

## Linux Partition
* /, /etc, /usr in same partition about 20Gb.
* /boot (with UEFI >= 512Mb)
* /home
* /var contains many small files, if you mount it in a separate partition, choose the file system wisely
* /data for data shared across different users
* /tmp, usualy a tmpfs (in volatile memroy)
* swap about 2x the amount of RAM with few RAM, less with more RAM.

* References
<https://en.wikipedia.org/wiki/GUID_Partition_Table>
<https://wiki.archlinux.org/index.php/Partitioning#GUID_Partition_Table>
