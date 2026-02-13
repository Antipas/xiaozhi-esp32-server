#!/bin/sh
set -eu

cd "$DEPLOY_PATH"

if [ "$USE_DOCKER_COMPOSE_PLUGIN" = "1" ]; then
  if [ "$PULL_POLICY" = "never" ]; then
    docker compose -f "$COMPOSE_FILE" up -d --remove-orphans --pull never
  else
    docker compose -f "$COMPOSE_FILE" up -d --remove-orphans --pull "$PULL_POLICY"
  fi
else
  if [ "$PULL_POLICY" = "always" ]; then
    docker-compose -f "$COMPOSE_FILE" pull
  fi
  docker-compose -f "$COMPOSE_FILE" up -d --remove-orphans
fi

docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
