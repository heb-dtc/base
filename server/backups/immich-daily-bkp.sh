#!/bin/bash

IMMICH_DIR=/home/flow/apps/immich
LOCAL_BKP_DIR=/home/flow/bkp/immich
CUBBIT_REMOTE=cubbit-crypted
B2_REMOTE=b2-crypted

echo "Starting immich daily backup at: $(date)"

# DB dump
docker exec -t immich_postgres pg_dumpall -c -U postgres | gzip > "$LOCAL_BKP_DIR/dump.sql.gz"

if [ $? -eq 0 ]; then
  # report to stato
  /usr/bin/curl --header "Authorization: Bearer 466489" --header "Content-Type: application/json" --request POST --data '{"server":"mars","task_id":"1", "task":"cubbit immich backup","date":"'"$(date)"'", "status": "running"}' https://stato.hebus.net/report

  # copy DB dump to cubbit
  /usr/bin/rclone -v sync $LOCAL_BKP_DIR/dump.sql.gz $CUBBIT_REMOTE:db --progress 

  if [ $? -eq 0 ]; then
    # copy upload dir/ to cubbit
    /usr/bin/rclone -v sync $IMMICH_DIR/library/upload/ $CUBBIT_REMOTE:upload --progress
    if [ $? -ne 0 ]; then
      echo "Failed to copy photos to cubbit." >&2
      # report to stato
      /usr/bin/curl --header "Authorization: Bearer 466489" --header "Content-Type: application/json" --request POST --data '{"server":"mars","task_id":"1", "task":"cubbit immich backup","date":"'"$(date)"'", "status": "failed"}' https://stato.hebus.net/report
      exit 1
    fi
  else
      echo "Failed to copy DB to cubbit." >&2
      # report to stato
      /usr/bin/curl --header "Authorization: Bearer 466489" --header "Content-Type: application/json" --request POST --data '{"server":"mars","task_id":"1", "task":"cubbit immich backup","date":"'"$(date)"'", "status": "failed"}' https://stato.hebus.net/report
      exit 1
  fi

  echo "backup to cubbit successful"
  # report to stato
  /usr/bin/curl --header "Authorization: Bearer 466489" --header "Content-Type: application/json" --request POST --data '{"server":"mars","task_id":"1", "task":"cubbit immich backup","date":"'"$(date)"'", "status": "done"}' https://stato.hebus.net/report

  # report to stato
  /usr/bin/curl --header "Authorization: Bearer 466489" --header "Content-Type: application/json" --request POST --data '{"server":"mars","task_id":"1", "task":"b2 immich backup","date":"'"$(date)"'", "status": "running"}' https://stato.hebus.net/report
  # copy DB dump to b2
  /usr/bin/rclone -v sync $LOCAL_BKP_DIR/dump.sql.gz $B2_REMOTE:db --progress 

  if [ $? -eq 0 ]; then
    # copy upload dir/ to b2
    /usr/bin/rclone -v sync $IMMICH_DIR/library/upload/ $B2_REMOTE:upload --progress
    if [ $? -ne 0 ]; then
      echo "Failed to copy photos to b2." >&2
      # report to stato
      /usr/bin/curl --header "Authorization: Bearer 466489" --header "Content-Type: application/json" --request POST --data '{"server":"mars","task_id":"1", "task":"b2 immich backup","date":"'"$(date)"'", "status": "failed"}' https://stato.hebus.net/report
      exit 1
    fi
  else
      echo "Failed to copy DB to b2." >&2
      # report to stato
      /usr/bin/curl --header "Authorization: Bearer 466489" --header "Content-Type: application/json" --request POST --data '{"server":"mars","task_id":"1", "task":"b2 immich backup","date":"'"$(date)"'", "status": "failed"}' https://stato.hebus.net/report
      exit 1
  fi

  echo "backup to b2 successful"
  # report to stato
  /usr/bin/curl --header "Authorization: Bearer 466489" --header "Content-Type: application/json" --request POST --data '{"server":"mars","task_id":"1", "task":"b2 immich backup","date":"'"$(date)"'", "status": "done"}' https://stato.hebus.net/report

else
  echo "The database dump failed." >&2
  exit 1
fi

echo "immich daily backup completed successfully at: $(date)"


