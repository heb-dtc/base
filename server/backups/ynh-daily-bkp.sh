#!/bin/sh

BKP_DIR="/home/yunohost.backup/daily-backups"
ARCH_DIR="/home/yunohost.backup/archives"
APPS="gitea baikal syncthing"
DATE=$(date +%Y-%m-%d)

echo "Starting daily apps backup at: $DATE"

if [ -d $BKP_DIR.bak ]; then rm -rf $BKP_DIR.bak; fi

mkdir -p $BKP_DIR
mkdir $BKP_DIR.bak
mv $BKP_DIR/* $BKP_DIR.bak || true

yunohost backup create --system conf_cron conf_ldap conf_nginx conf_ssh conf_ssowat conf_xmpp conf_ynh_certs conf_ynh_currenthost conf_ynh_firewall -n system_conf
gzip $ARCH_DIR/system_conf.tar
mv $ARCH_DIR/system_conf.tar.gz $BKP_DIR/system_conf.$DATE.tar.gz
rm $ARCH_DIR/system_conf.info.json

for app in $APPS; do
  echo "backing up $app"
  yunohost backup create --apps $app -n $app
  gzip $ARCH_DIR/$app.tar
  mv $ARCH_DIR/$app.tar.gz $BKP_DIR/$app.$DATE.tar.gz
  rm $ARCH_DIR/$app.info.json
done

/usr/bin/rclone -vv sync $BKP_DIR mars-backup:bkp/ynh-daily-backup --progress
if [ $? -eq 0 ]; then
  /usr/bin/rclone -vv sync $BKP_DIR b2-crypted-apps:ynh-daily-backup --progress
  if [ $? -eq 0 ]; then
    rm -rf $BKP_DIR.bak
  else
    echo "failed to copy backups to b2" >&2
    exit 1
  fi
else
  echo "failed to copy backups to mars" >&2
  exit 1
fi

echo "daily app backup to completed successfully at: $(date)"
