#!/bin/sh

set -e

DATE=$(date +%Y-%m-%d)
BKP_DIR="/home/yunohost.backup/daily-backups"
APPS="gitea baikal"

mkdir -p $BKP_DIR 
mkdir $BKP_DIR.bak
mv $BKP_DIR/* $BKP_DIR.bak

yunohost backup create --system conf_cron conf_ldap conf_nginx conf_ssh conf_ssowat conf_xmpp conf_ynh_certs conf_ynh_currenthost conf_ynh_firewall -r -o $BKP_DIR/system_conf
tar -cvzf $BKP_DIR/system_conf.tar.gz $BKP_DIR/system_conf
rm -rf $BKP_DIR/system_conf

for app in $APPS; do
    yunohost backup create --apps $app -r -o $BKP_DIR/$app
    tar -cvzf $BKP_DIR/$app.tar.gz $BKP_DIR/$app
    rm -rf $BKP_DIR/$app
done

/usr/bin/rclone -vv sync $BKP_DIR mars-backup:bkp/ynh-daily-backup
/usr/bin/rclone -vv sync $BKP_DIR goupil-backup:backups/ynh-daily-backup

rm -rf $BKP_DIR.bak
