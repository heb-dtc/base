#!/bin/bash

nextcloud_data_dir=/home/yunohost.app/nextcloud/data/
remote_dir_1=dir1_path 
remote_dir_2=dir2_path  

ssh_host_1=host1_domain
ssh_host_2=host2_domain
ssh_pwd=pasword
ssh_key=/home/admin/.ssh/id_rsa
ssh_port=22
ssh_user_1=user1
ssh_user_2=user2

date

echo "-> nextcloud data backup"
echo "-> pushing data $ssh_host_1"
rsync -av --delete --exclude 'appdata_ocwpdbbrpg8q' --rsh="ssh -i $ssh_key -p $ssh_port" $nextcloud_data_dir $ssh_user_1@$ssh_host_1:$remote_dir_1
echo "-> pushing data $ssh_host_2"
rsync -av --delete --exclude 'appdata_ocwpdbbrpg8q' --rsh="ssh -i $ssh_key -p $ssh_port" $nextcloud_data_dir $ssh_user_2@$ssh_host_2:$remote_dir_2
echo "-> nextcloud data backup done"

