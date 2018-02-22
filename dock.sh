#!/bin/sh
compose="-f docker-compose.yml"
for var in "$@"; do
compose="$compose -f docker-compose.$var.yml"
done
rm -rf * && tar -x && docker-compose $compose -p app up --build --remove-orphans -d
