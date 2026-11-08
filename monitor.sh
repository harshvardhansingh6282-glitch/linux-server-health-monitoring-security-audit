#!/bin/bash


REPORT="health_report_$(date +%Y%m%d_%H%M%S).txt"

# CPU calculation
read cpu user nice system idle iowait irq softirq steal rest < /proc/stat
IDLE1=$((idle + iowait))
TOTAL1=$((user + nice + system + idle + iowait + irq + softirq + steal))

sleep 1

read cpu user nice system idle iowait irq softirq steal rest < /proc/stat
IDLE2=$((idle + iowait))
TOTAL2=$((user + nice + system + idle + iowait + irq + softirq + steal))

CPU=$(awk -v i1="$IDLE1" -v i2="$IDLE2" \
-v t1="$TOTAL1" -v t2="$TOTAL2" \
'BEGIN {printf "%.1f", 100*(1-(i2-i1)/(t2-t1))}')

# Memory calculation
MEM=$(free -b | awk '/Mem:/ {
printf "%.1f", (($2-$7)/$2)*100
}')

# Root disk usage
DISK=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

{
echo "===================================="
echo "       LINUX SERVER HEALTH REPORT"
echo "===================================="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo ""
echo "CPU USAGE: $CPU%"
echo "MEMORY USAGE: $MEM%"
echo "ROOT DISK USAGE: $DISK%"
echo ""
echo "----- HEALTH ALERTS -----"

if awk "BEGIN {exit !($CPU > 80)}"; then
    echo "WARNING: High CPU usage!"
else
    echo "CPU: NORMAL"
fi

if awk "BEGIN {exit !($MEM > 80)}"; then
    echo "WARNING: High memory usage!"
else
    echo "MEMORY: NORMAL"
fi

if [ "$DISK" -gt 80 ]; then
    echo "WARNING: High disk usage!"
else
    echo "DISK: NORMAL"
fi

echo ""
echo "----- MEMORY DETAILS -----"
free -h

echo ""
echo "----- DISK DETAILS -----"
df -h /

echo ""
echo "----- TOP PROCESSES -----"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

echo ""
echo "----- SYSTEM UPTIME -----"
uptime

} > "$REPORT"

echo "Monitoring completed successfully!"
echo "Report saved: $REPORT"
