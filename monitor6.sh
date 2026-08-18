#!/bin/bash

#################################
# SERVER HEALTH MONITOR
#################################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

HOSTNAME=$(hostname)
CURRENT_DATE=$(date)

SERVER_STATUS="HEALTHY"

#################################
# CPU CHECK
#################################

check_cpu() {

    CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print int(100-$8)}')

    echo "CPU Usage: ${CPU_USAGE}%"

    if [ "$CPU_USAGE" -gt 80 ]; then
        echo -e "${YELLOW}WARNING: CPU Usage Above 80%${NC}"
        SERVER_STATUS="UNHEALTHY"
    fi
}

#################################
# MEMORY CHECK
#################################

check_memory() {

    MEMORY_USAGE=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')

    echo "Memory Usage: ${MEMORY_USAGE}%"

    if [ "$MEMORY_USAGE" -gt 90 ]; then
        echo -e "${YELLOW}WARNING: Memory Usage Above 90%${NC}"
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
        echo -e "${YELLOW}WARNING: Disk Usage Above 80%${NC}"
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

    DOCKER_STATUS=$(systemctl is-active docker 2>/dev/null)

    echo "Docker Status: $DOCKER_STATUS"

    if [ "$DOCKER_STATUS" != "active" ]; then
        echo -e "${RED}CRITICAL: Docker Service Down${NC}"
        SERVER_STATUS="UNHEALTHY"
    fi
}

#################################
# NGINX CHECK
#################################

check_nginx() {

    NGINX_STATUS=$(systemctl is-active nginx 2>/dev/null)

    echo "Nginx Status: $NGINX_STATUS"

    if [ "$NGINX_STATUS" != "active" ]; then
        echo -e "${RED}CRITICAL: Nginx Service Down${NC}"
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
# REPORT
#################################

echo ""
echo "================================="
echo "      SERVER HEALTH REPORT"
echo "================================="
echo "Timestamp: $CURRENT_DATE"
echo "Hostname : $HOSTNAME"
echo ""

check_cpu
echo ""

check_memory
echo ""

check_disk
echo ""

check_uptime
echo ""

check_docker
echo ""

check_nginx
echo ""

check_processes

echo ""
echo "================================="

if [ "$SERVER_STATUS" = "HEALTHY" ]; then
    echo "Server Status: HEALTHY"
else
    echo "Server Status: UNHEALTHY"
fi

echo "================================="
echo ""

if [ "$SERVER_STATUS" = "HEALTHY" ]; then
    exit 0
else
    exit 1
fi