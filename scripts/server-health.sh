#!/bin/bash

LOG_DIR="$HOME/cloud-project/logs"
LOG_FILE="$LOG_DIR/server-health.log"

mkdir -p "$LOG_DIR"

{
echo "======================================"
echo "       AWS SERVER HEALTH CHECK"
echo "======================================"

echo
echo "Date: $(date)"
echo "Hostname: $(hostname)"

echo
echo "Uptime:"
uptime -p

echo
echo "CPU Usage:"
CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')
echo "CPU Usage: ${CPU_USAGE}%"

echo
echo "Memory Usage:"
free -h

echo
echo "Disk Usage:"
df -h /

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$DISK_USAGE" -ge 80 ]; then
    echo "WARNING: Disk usage is above 80%."
else
    echo "Disk usage: OK"
fi

echo
echo "Nginx Status:"

if systemctl is-active --quiet nginx; then
    echo "Nginx: RUNNING"
else
    echo "WARNING: Nginx is NOT running."
fi

echo
echo "Logged-in Users:"
who

echo
echo "======================================"
echo "       HEALTH CHECK COMPLETE"
echo "======================================"

} | tee -a "$LOG_FILE"
