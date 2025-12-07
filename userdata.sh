#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

DISK="/dev/nvme1n1"
[ ! -e $DISK ] && DISK="/dev/xvdf"

if file -s $DISK | grep -q "data"; then
    mkfs -t ext4 $DISK
fi

mkdir -p /my_new_data
mount $DISK /my_new_data

echo "$(blkid -o export $DISK | grep UUID) /my_new_data ext4 defaults,nofail 0 2" >> /etc/fstab



sudo apt-get update
sudo apt-get install -y nfs-common


mkdir -p /mnt/efs_share

EFS_DNS="fs-072e9e9582135f914.efs.us-east-1.amazonaws.com"

mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $EFS_DNS:/ /mnt/efs_share

echo "$EFS_DNS:/ /mnt/efs_share nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0" >> /etc/fstab

echo "ALL DONE!"
