#!/bin/bash

NEXTCLOUD_DATA_DIR=/home/yunohost.app/nextcloud/data/
remote_dir_2=/home/flow/bkp/nextcloud_data
B2_REMOTE=b2-crypted-nextcloud

ssh_host_2=mars.hebus.net
ssh_key=/home/admin/.ssh/id_ed25519
ssh_port_2=9321
ssh_user_2=flow

echo "Starting nextcloud daily data backup at $(date)"
#echo "pushing data to mars"
#rsync -av --delete --exclude 'appdata_ocqc4oygiipv' --rsh="ssh -i $ssh_key -p $ssh_port_2" $nextcloud_data_dir $ssh_user_2@$ssh_host_2:$remote_dir_2

# pushing data to b2
/usr/bin/rclone -v sync $NEXTCLOUD_DATA_DIR $B2_REMOTE:files --progress
if [ $? -ne 0 ]; then
	echo "Failed to copy data to b2." >&2
	exit 1
fi

echo "Nextcloud data backup completed successfully at $(date)"
