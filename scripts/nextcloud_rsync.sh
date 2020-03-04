#!/bin/bash

nextcloud_data_dir=/home/yunohost.app/nextcloud/data/
remote_dir=/home/flow/backups/nextcloud_data

ssh_host=192.168.1.10
ssh_pwd=education_wages_sleek_protract
ssh_port=22
ssh_user=flow

date

echo "-> nextcloud data backup routine"
echo "-> running rsync"
rsync -av --delete --rsh="sshpass -p $ssh_pwd ssh -p $ssh_port" $nextcloud_data_dir $ssh_user@$ssh_host:$remote_dir
echo "-> sending mail"
mail -s "NextCloud data backup done" florent.noel@protonmail.com < /dev/null
echo "-> nextcloud data backup done"
