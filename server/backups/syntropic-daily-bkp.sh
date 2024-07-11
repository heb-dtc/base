#!/bin/bash

SYNTROPIC_DIR=/home/flo/dev/SyntropicFarming/backend_go/uploads
LOCAL_BKP_DIR=/home/flo/bkp/syntropic

echo "Starting syntropic daily backup at: $(date)"

# DB dump
docker exec -i syntropic-db-container pg_dump syntropic_farming --username syntropic > $LOCAL_BKP_DIR/syntropic_farming.sql
if [ $? -eq 0 ]; then
    # copy DB dump to cubbit
    /usr/bin/rclone -v sync $LOCAL_BKP_DIR/syntropic_farming.sql cubbit:flow-syntropic/db --progress

    if [ $? -eq 0 ]; then
        # copy upload dir/ to cubbit
        /usr/bin/rclone -v sync $SYNTROPIC_DIR cubbit:flow-syntropic/upload --progress
        if [ $? -ne 0 ]; then
            echo "Failed to copy uploads to cubbit." >&2
            exit 1
        fi
    else
        echo "Failed to copy DB to cubbit." >&2
        exit 1
    fi
else
    echo "The database dump failed." >&2
    exit 1
fi

echo "syntropic daily backup to cubbit completed successfully at: $(date)"

