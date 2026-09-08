#!/usr/bin/env bash

set -euo pipefail

echo "=== System Information ==="
echo "User: $(id -un)"
echo "Effective UID: $(id -u)"
echo "Hostname: $(hostname)"
echo "Kernel Release: $(uname -r)"
echo "System Date (ISO-8601): $(date -u '+%Y-%m-%dT%H:%M:%SZ')"

echo
echo "--- Disk Usage (human-readable) ---"
df -h

echo
echo "--- Memory Usage ---"

if command -v free >/dev/null 2>&1; then
    free -h
elif command -v vm_stat >/dev/null 2>&1; then
    vm_stat
else
    echo "Memory information command is not available on this system."
fi

echo
echo "--- Docker Daemon Status ---"

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker daemon: docker CLI not installed"
elif docker info >/dev/null 2>&1; then
    echo "Docker daemon: running"
else
    echo "Docker daemon: not running or not accessible"
fi
