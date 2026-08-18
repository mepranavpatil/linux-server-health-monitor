# Cloud Project 03 - Linux Server Health Monitoring

A Bash-based server monitoring solution that automates health checks for Linux servers and EC2 instances.

The script collects critical system metrics such as CPU usage, memory utilization, disk usage, service status, uptime, and running processes, then generates a detailed health report. It can also run automatically using cron for continuous monitoring.

This project was built to strengthen Linux administration, Bash scripting, automation, and troubleshooting skills commonly required in Cloud and DevOps engineering roles.

---

# Project Architecture

```text
Linux Server / EC2 Instance
            │
            ▼
      monitor.sh
            │
            ├── CPU Usage Check
            ├── Memory Usage Check
            ├── Disk Usage Check
            ├── Docker Status Check
            ├── Nginx Status Check
            ├── Uptime Check
            ├── Running Processes Check
            │
            ▼
      Health Evaluation
            │
            ▼
      Health Report
            │
            ▼
      Log File Storage
            │
            ▼
      Cron Automation
```

---

# Project Objectives

The primary goal of this project is to automate Linux server health monitoring using Bash scripting.

This project helps develop practical experience with:

- Linux Administration
- Bash Scripting
- Process Monitoring
- Service Monitoring
- System Troubleshooting
- Cron Automation
- Logging
- Performance Analysis

---

# Technologies Used

| Technology | Purpose |
|------------|----------|
| Linux | Operating System |
| Bash | Automation & Scripting |
| Cron | Scheduled Execution |
| Docker | Service Monitoring |
| Nginx | Service Monitoring |
| Git | Version Control |
| GitHub | Project Hosting |

---

# Features

### System Monitoring

- CPU Usage Monitoring
- Memory Usage Monitoring
- Disk Usage Monitoring
- System Uptime Monitoring
- Hostname Reporting

### Service Monitoring

- Docker Status Check
- Nginx Status Check

### Process Monitoring

- Top CPU Consuming Processes

### Automation

- Scheduled Monitoring with Cron
- Health Report Generation
- Log File Creation
- Exit Code Handling

### Health Evaluation

- Detects High CPU Usage
- Detects High Memory Usage
- Detects High Disk Usage
- Detects Failed Services
- Generates HEALTHY / UNHEALTHY Status

---

# Project Structure

```text
cloud-project-03-server-monitoring/
│
├── monitor.sh
├── README.md
├── .gitignore
│
├── logs/
│   └── server-health.log
│
└── screenshots/
    ├── script-output.png
    ├── cron-config.png
    ├── log-file.png
    ├── docker-status.png
    └── nginx-status.png
```

---

# Monitoring Metrics

## CPU Usage

The script monitors CPU utilization and alerts if usage exceeds 80%.

Command used:

```bash
top -bn1
```

Example:

```text
CPU Usage: 82%
WARNING: CPU Usage Above 80%
```

---

## Memory Usage

The script calculates memory utilization percentage.

Command used:

```bash
free
```

Example:

```text
Memory Usage: 74%
```

Alert threshold:

```text
90%
```

---

## Disk Usage

The script monitors root filesystem usage.

Command used:

```bash
df -h /
```

Example:

```text
Disk Usage: 85%
WARNING: Disk Usage Above 80%
```

---

## Docker Service Status

Checks whether Docker is running.

Command used:

```bash
systemctl is-active docker
```

Possible outputs:

```text
active
inactive
failed
```

---

## Nginx Service Status

Checks whether Nginx is running.

Command used:

```bash
systemctl is-active nginx
```

Possible outputs:

```text
active
inactive
failed
```

---

## System Uptime

Displays how long the server has been running.

Command used:

```bash
uptime
```

Example:

```text
up 5 days, 3 hours
```

---

## Top Processes

Displays the top CPU-consuming processes.

Command used:

```bash
ps aux --sort=-%cpu | head -6
```

---

# Sample Output

```text
=================================
      SERVER HEALTH REPORT
=================================

Timestamp: Tue Aug 18 2026
Hostname : ip-172-31-6-81

CPU Usage: 14%

Memory Usage: 38%

Disk Usage: 22%

System Uptime:
10:45:02 up 5 days, 3 hours

Docker Status: active

Nginx Status: active

Top 5 CPU Consuming Processes
-----------------------------
USER       PID %CPU %MEM COMMAND
root      1034 12.0  1.2 docker
nginx      872  4.2  0.4 nginx

=================================
Server Status: HEALTHY
=================================
```

---

# Installation

## Clone Repository

```bash
git clone https://github.com/<your-username>/cloud-project-03-server-monitoring.git

cd cloud-project-03-server-monitoring
```

---

# Grant Execute Permission

```bash
chmod +x monitor.sh
```

---

# Run Script

```bash
./monitor.sh
```

---

# Understanding the Script

The monitoring script uses:

### Variables

```bash
HOSTNAME=$(hostname)

CURRENT_DATE=$(date)

SERVER_STATUS="HEALTHY"
```

Variables are used to store dynamic system information.

---

### Functions

Example:

```bash
check_cpu() {
    ...
}
```

Functions improve readability and maintainability.

---

### Conditional Statements

Example:

```bash
if [ "$CPU_USAGE" -gt 80 ]
then
    SERVER_STATUS="UNHEALTHY"
fi
```

Used to determine server health.

---

### Exit Codes

```bash
exit 0
```

Means:

```text
Success
```

```bash
exit 1
```

Means:

```text
Failure
```

Useful for automation tools and monitoring systems.

---

# Logging

Create log directory:

```bash
mkdir -p logs
```

Create log file:

```bash
touch logs/server-health.log
```

Run script and save output:

```bash
./monitor.sh >> logs/server-health.log
```

View logs:

```bash
cat logs/server-health.log
```

View latest entries:

```bash
tail -20 logs/server-health.log
```

---

# Cron Automation

Cron allows the script to run automatically at scheduled intervals.

---

## Edit Crontab

```bash
crontab -e
```

---

## Run Every 5 Minutes

```cron
*/5 * * * * /home/ec2-user/cloud-project-03-server-monitoring/monitor.sh >> /home/ec2-user/cloud-project-03-server-monitoring/logs/server-health.log 2>&1
```

---

## Verify Cron Jobs

```bash
crontab -l
```

---

# Common Linux Commands Used

| Command | Purpose |
|----------|----------|
| hostname | Server Name |
| date | Current Date & Time |
| top | CPU Monitoring |
| free | Memory Monitoring |
| df | Disk Monitoring |
| uptime | Uptime Information |
| ps | Process Monitoring |
| systemctl | Service Monitoring |
| awk | Text Processing |
| grep | Pattern Matching |
| tr | String Manipulation |

---

# Health Evaluation Logic

The server is considered:

### HEALTHY

When:

- CPU Usage ≤ 80%
- Memory Usage ≤ 90%
- Disk Usage ≤ 80%
- Docker Running
- Nginx Running

---

### UNHEALTHY

When any of the following occur:

- CPU Usage > 80%
- Memory Usage > 90%
- Disk Usage > 80%
- Docker Service Down
- Nginx Service Down

---



### Script Execution

```text
./monitor.sh
```

### Log File Output

```text
logs/server-health.log
```

### Cron Configuration

```text
crontab -l
```

### Docker Status

```text
systemctl status docker
```

### Nginx Status

```text
systemctl status nginx
```

---

# Skills Gained

Through this project, I gained practical experience in:

- Linux Administration
- Bash Scripting
- Shell Automation
- Monitoring and Troubleshooting
- Process Management
- Service Management
- Log Management
- Cron Scheduling
- System Health Analysis
- Cloud Infrastructure Operations

---

# Future Improvements

Potential enhancements include:

- Email Alerts
- Slack Notifications
- Disk Cleanup Automation
- Docker Container Monitoring
- Multi-Server Monitoring
- AWS CloudWatch Integration
- Prometheus Metrics Export
- Grafana Dashboard Integration
- Log Rotation Automation
- System Resource Trend Analysis

---

# Learning Outcomes

After completing this project, I can:

- Write Bash scripts using variables and functions
- Use conditional logic for automation
- Monitor Linux system resources
- Check service health automatically
- Generate health reports
- Schedule recurring tasks with cron
- Analyze server performance metrics
- Automate operational tasks

---

# Author

**Pranav Patil**

Aspiring Cloud & DevOps Engineer

GitHub: https://github.com/mepranavpatil