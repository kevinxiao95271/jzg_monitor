#!/usr/bin/env bash
# -----------------------------------
# -----------------------------------
grep -E "/app/wxs/|MiniProgram" /services/data/logs/nginx/jzg-api-backup.log | grep "$1" | wc -l
