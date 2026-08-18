#!/bin/bash

#################################
# SERVER HEALTH MONITOR
#################################

HOSTNAME=$(hostname)
CURRENT_DATE=$(date)

SERVER_STATUS="HEALTHY"

#################################
# MEMORY CHECK
#################################

check_memory() {

    MEMORY_USAGE=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')

    echo "Memory Usage: ${MEMORY_USAGE}%"

    if [ "$MEMORY_USAGE" -gt 90 ]; then
        echo "WARNING: Memory Usage Above 90%"
        SERVER_STATUS="UNHEALTHY"
    fi
}

#################################
# DISK CHECK
#################################

check_disk() {

    DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

    echo "Disk Usage: ${DISK_USAGE}%"

    if [ "$DISK_USAGE" -gt 80 ]; then
        echo "WARNING: Disk Usage Above 80%"
        SERVER_STATUS="UNHEALTHY"
    fi
}

#################################
# UPTIME CHECK
#################################

check_uptime() {

    echo "System Uptime:"
    uptime
}

#################################
# DOCKER CHECK
#################################

check_docker() {

    DOCKER_STATUS=$(systemctl is-active docker)

    echo "Docker Status: $DOCKER_STATUS"

    if [ "$DOCKER_STATUS" != "active" ]; then
        echo "CRITICAL: Docker Service Down"
        SERVER_STATUS="UNHEALTHY"
    fi
}

#################################
# NGINX CHECK
#################################

check_nginx() {

    NGINX_STATUS=$(systemctl is-active nginx)

    echo "Nginx Status: $NGINX_STATUS"

    if [ "$NGINX_STATUS" != "active" ]; then
        echo "CRITICAL: Nginx Service Down"
        SERVER_STATUS="UNHEALTHY"
    fi
}

#################################
# TOP PROCESSES
#################################

check_processes() {

    echo ""
    echo "Top 5 CPU Consuming Processes"
    echo "-----------------------------"

    ps aux --sort=-%cpu | head -6
}

#################################
# REPORT HEADER
#################################

echo "================================="
echo "      SERVER HEALTH REPORT"
echo "================================="
echo ""

echo "Hostname: $HOSTNAME"
echo "Date: $CURRENT_DATE"

echo ""
echo "---------------------------------"

check_memory

echo ""
echo "---------------------------------"

check_disk

echo ""
echo "---------------------------------"

check_uptime

echo ""
echo "---------------------------------"

check_docker

echo ""
echo "---------------------------------"

check_nginx

echo ""
echo "---------------------------------"

check_processes

echo ""
echo "================================="
echo "Server Status: $SERVER_STATUS"
echo "================================="