#!/bin/env bash

LOG_FILE="/var/log/sysmon.log"

while true; do
  {
    echo "--- $(date) ---"

    echo "CPU: $(mpstat 1 1 | awk '/Average/ {print "User:", $3"%", "System:", $5"%", "Idle:", $12"%"}')"

    echo "MEMORY: $(free -h)"

    echo "DISK: $(df -h --output=source,fstype,size,used,avail,pcent,target)"

    echo "NETWORK: $(ip -s link show eth0 | awk '/^[0-9]+:/ {print $2} /RX:/{getline; print "RX:", $1, "packets,", $2, "bytes"} /TX:/{getline; print "TX:", $1, "packets,", $2, "bytes"}')"

    echo ""
  } >> "$LOG_FILE"
  sleep 300
done
