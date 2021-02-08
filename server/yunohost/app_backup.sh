#!/bin/sh

set -e

DATE=$(date +%Y-%m-%d)
echo $DATE

BKP_DIR="/home/yunohost.backup/daily-backups"
ARCH_DIR="/home/yunohost.backup/archives"
APPS="gitea baikal"

if [ -d $BKP_DIR.bak ]; then rm -rf $BKP_DIR.bak; fi

mkdir -p $BKP_DIR
mkdir $BKP_DIR.bak
mv $BKP_DIR/* $BKP_DIR.bak || true

yunohost backup create --system conf_cron conf_ldap conf_nginx conf_ssh conf_ssowat conf_xmpp conf_ynh_certs conf_ynh_currenthost conf_ynh_firewall -n system_conf
gzip $ARCH_DIR/system_conf.tar
mv $ARCH_DIR/system_conf.tar.gz $BKP_DIR/system_conf.$DATE.tar.gz
rm $ARCH_DIR/system_conf.info.json

for app in $APPS; do
    yunohost backup create --apps $app -n $app
    gzip $ARCH_DIR/$app.tar
    mv $ARCH_DIR/$app.tar.gz $BKP_DIR/$app.$DATE.tar.gz
    rm $ARCH_DIR/$app.info.json
done

/usr/bin/rclone -vv sync $BKP_DIR mars-backup:bkp/ynh-daily-backup
/usr/bin/rclone -vv sync $BKP_DIR goupil-backup:backups/ynh-daily-backup

rm -rf $BKP_DIR.bak
