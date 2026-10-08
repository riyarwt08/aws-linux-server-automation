#!/bin/bash

BUCKET="cloud-server-backup-riya-20261008"
LOG_FILE="$HOME/cloud-project/logs/server-health.log"
BACKUP_PATH="s3://$BUCKET/health-logs/server-health.log"

aws s3 cp "$LOG_FILE" "$BACKUP_PATH"

if [ $? -eq 0 ]; then
    echo "$(date): S3 backup successful."
else
    echo "$(date): ERROR - S3 backup failed."
fi

