#!/bin/bash

HOSTNAME=$(hostname)
CURRENT_DATE=$(date)

check_memory() {
    echo ""
    echo "Memory Usage:"
    free -h
}

check_disk() {
    echo ""
    echo "Disk Usage:"
    df -h /
}

check_uptime() {
    echo ""
    echo "System Uptime:"
    uptime
}

check_docker() {
    echo ""
    echo "Docker Status:"
    systemctl is-active docker
}

check_nginx() {
    echo ""
    echo "Nginx Status:"
    systemctl is-active nginx
}

check_processes() {
    echo ""
    echo "Top Processes:"
    ps aux --sort=-%cpu | head -5
}

echo "================================="
echo "      SERVER HEALTH REPORT"
echo "================================="

echo "Hostname: $HOSTNAME"
echo "Date: $CURRENT_DATE"

check_memory
check_disk
check_uptime
check_docker
check_nginx
check_processes