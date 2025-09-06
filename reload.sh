#!/usr/bin/env bash
set -euo pipefail

DOCKER_COMPOSE_CMD="docker-compose"

echo "♻️ Rebuilding web only..."
$DOCKER_COMPOSE_CMD build web
$DOCKER_COMPOSE_CMD up -d web

echo "✅ Web container reloaded!"
$DOCKER_COMPOSE_CMD logs --tail=20 web
