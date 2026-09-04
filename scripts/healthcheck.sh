#!/bin/sh
set -eu

TARGET_URL="${1:-http://localhost:8080/healthz}"

printf "Checking health endpoint: %s ... " "${TARGET_URL}"

if ! command -v curl >/dev/null 2>&1; then
    echo "ERROR: curl is required but not installed." >&2
    exit 1
fi

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "${TARGET_URL}" || true)

if [ "${HTTP_STATUS}" = "200" ]; then
    printf "SUCCESS (HTTP 200)\n"
    exit 0
else
    printf "FAILED (HTTP %s)\n" "${HTTP_STATUS}" >&2
    echo "Diagnostic: Target '${TARGET_URL}' failed health check." >&2
    exit 1
fi