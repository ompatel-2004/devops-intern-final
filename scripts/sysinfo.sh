#!/bin/sh
set -eu

echo "=========================================="
echo "          SYSTEM INFORMATION              "
echo "=========================================="

echo "User / Effective UID:"
printf "  User: %s (UID: %s)\n" "$(id -un)" "$(id -u)"

printf "\nHostname & Kernel:\n"
printf "  Hostname: %s\n" "$(hostname)"
printf "  Kernel:   %s\n" "$(uname -r)"

printf "\nSystem Date (ISO-8601):\n"
printf "  %s\n" "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

printf "\nDisk Usage:\n"
df -h / | awk 'NR==1 || NR==2 {print "  " $0}'

printf "\nMemory Usage:\n"
if command -v free >/dev/null 2>&1; then
    free -h | awk '{print "  " $0}'
else
    echo "  'free' utility not available on this host"
fi

printf "\nDocker Daemon Status:\n"
if command -v docker >/dev/null 2>&1; then
    if docker info >/dev/null 2>&1; then
        echo "  Docker is running"
    else
        echo "  Docker daemon is not accessible / stopped"
    fi
else
    echo "  Docker is not installed"
fi
echo "=========================================="