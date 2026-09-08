#!/usr/bin/env bash

set -euo pipefail

URL="${1:-http://localhost:8080}"

if ! http_code="$(curl -sS -o /dev/null -w '%{http_code}' "$URL")"; then
    http_code="000"
fi

if [ "$http_code" = "200" ]; then
    echo "OK: $URL returned HTTP 200"
    exit 0
fi

echo "FAIL: $URL returned HTTP $http_code (expected 200)"
exit 1
