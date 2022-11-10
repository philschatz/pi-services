#!/usr/bin/env bash

# Paste the following line into 'crontab -e'
# */15 * * * * $HOME/pi-services/cron-pre-gen.sh > /dev/null 2>&1

# From https://github.com/nextcloud/docker/issues/1775

echo "--- $(date --utc +%FT%TZ) START ----------------------------------------" >>$HOME/cron-pre-generate.log 2>&1
docker exec -i --user 33 pi-services-app-1 ./occ preview:pre-generate -v >>$HOME/cron-pre-generate.log 2>&1
echo "--- $(date --utc +%FT%TZ) END ----------------------------------------" >>$HOME/cron-pre-generate.log 2>&1
