# Linux Server Health Monitoring & Security Audit

## Project Overview
A beginner-friendly Linux administration project built using Bash scripting on Ubuntu WSL2. It monitors basic system health and collects available security-related information into timestamped reports.

## Objectives
- Monitor CPU, memory and disk usage.
- Identify high resource usage.
- Display top processes by CPU usage.
- Collect available user-session and login information.
- Review available sudo activity logs.
- Generate timestamped text reports.

## Technologies Used
- Ubuntu Linux (WSL2)
- Bash scripting
- Linux commands: free, df, ps, uptime, who
- Linux system logs

## Project Files
- monitor.sh — system health monitoring script.
- security_audit.sh — security information and log audit script.
- health_report_*.txt — generated system health reports.
- security_report_*.txt — generated security audit reports.

## How to Run

Make the scripts executable:

    chmod +x monitor.sh security_audit.sh

Run system monitoring:

    ./monitor.sh

Run the security audit:

    ./security_audit.sh

View generated reports:

    ls -lh
    cat health_report_*.txt
    cat security_report_*.txt

## Monitoring Checks
- CPU utilization
- Memory utilization
- Root filesystem disk utilization
- Top five CPU-consuming processes
- System uptime

The monitoring script reports a warning when CPU, memory or disk usage exceeds 80%.

## Security Audit Checks
- Current user-session information, where available
- Recent login history, where supported
- Failed-login information from auth.log, where readable
- Available sudo activity records

## Environment Notes
This project was developed and tested on Ubuntu running under WSL2 on Windows 11. Some traditional Linux login-history commands and authentication logs may not be available in WSL2. The security script handles these limitations and reports when information is unavailable.

## Learning Outcomes
- Practiced Linux system administration commands.
- Created and executed Bash scripts.
- Worked with Linux process and resource monitoring.
- Read available system and security logs.
- Generated automated timestamped reports.
- Practiced basic troubleshooting in Ubuntu.

## Future Improvements
- Schedule monitoring using cron on a full Linux server.
- Send alerts when resource usage exceeds thresholds.
- Add log rotation and report cleanup.
- Test security auditing on a dedicated Linux virtual machine.

## Disclaimer
This is a learning project, not a replacement for enterprise monitoring or security auditing tools.
