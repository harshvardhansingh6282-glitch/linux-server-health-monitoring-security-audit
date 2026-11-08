#!/bin/bash

REPORT="security_report_$(date +%Y%m%d_%H%M%S).txt"

{
echo "===================================="
echo "       LINUX SECURITY AUDIT"
echo "===================================="
echo "Date: $(date)"
echo "Hostname: $(hostname)"

echo ""
echo "----- CURRENT USERS -----"
who

echo ""
echo "----- LOGIN HISTORY -----"

if command -v last >/dev/null 2>&1; then
    last -n 10
else
    echo "Login history command unavailable in this WSL2 environment."
fi

echo ""
echo "----- FAILED LOGIN ATTEMPTS -----"

if [ -r /var/log/auth.log ]; then
    grep -iE "failed password|authentication failure|invalid user" \
    /var/log/auth.log | tail -n 10
else
    echo "Authentication log unavailable in this WSL2 environment."
fi

echo ""
echo "----- SUDO COMMAND HISTORY -----"
if [ -r /var/log/auth.log ]; then
    grep -i "sudo" /var/log/auth.log | tail -n 10
else
    echo "Sudo logs unavailable."
fi

echo ""
echo "Security audit completed."

} > "$REPORT"

echo "Security audit completed successfully!"
echo "Report saved: $REPORT"
