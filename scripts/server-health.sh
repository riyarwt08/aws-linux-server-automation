#!/bin/bash

echo "======================================"
echo "       AWS SERVER HEALTH CHECK"
echo "======================================"

echo
echo "Hostname:"
hostname

echo
echo "Date and Time:"
date

echo
echo "Uptime:"
uptime -p

echo
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'

echo
echo "Memory Usage:"
free -h

echo
echo "Disk Usage:"
df -h /

echo
echo "Nginx Status:"
if systemctl is-active --quiet nginx
then
    echo "Nginx: RUNNING"
else
    echo "Nginx: NOT RUNNING"
fi

echo
echo "Logged-in Users:"
who

echo
echo "======================================"
echo "       HEALTH CHECK COMPLETE"
echo "======================================"
