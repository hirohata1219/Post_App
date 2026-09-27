#!/bin/bash

set -e

DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p backups

docker compose exec -T db \
  pg_dump -U postgres a_development \
  > "backups/db_${DATE}.sql"

echo "Backup completed: backups/db_${DATE}.sql"