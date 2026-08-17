#!/bin/bash
hostname

date

uptime

free -h

df -h

top

ps aux

ps aux --sort=-%cpu | head

systemctl is-active docker

systemctl is-active nginx