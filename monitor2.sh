#!/bin/bash

echo "================================="
echo "      SERVER HEALTH REPORT"
echo "================================="

echo "Hostname: $(hostname)"
echo "Date: $(date)"

echo ""
echo "Memory Usage:"
free -h

echo ""
echo "Disk Usage:"
df -h /

echo ""
echo "System Uptime:"
uptime

echo ""
echo "Docker Status:"
systemctl is-active docker

echo ""
echo "Nginx Status:"
systemctl is-active nginx

echo ""
echo "Top Processes:"
ps aux --sort=-%cpu | head -5