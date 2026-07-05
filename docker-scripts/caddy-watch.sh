#!/bin/bash

CADDYFILE="/home/sebastian/docker-configs/caddy/Caddyfile"
CONTAINER="caddy"

echo "Watching $CADDYFILE..."

while true; do
    inotifywait -e close_write,moved_to "$CADDYFILE"

    echo "$(date): Reloading Caddy..."

    docker exec "$CONTAINER" caddy reload \
        --config /etc/caddy/Caddyfile \
        --adapter caddyfile

    sleep 1
done
