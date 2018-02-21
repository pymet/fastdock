#!/bin/sh
rm -rf * && tar -x && docker-compose -p app up --build --remove-orphans -d
