#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/srv/apps/django-dashboard"
DOCKER_COMPOSE_CMD="docker compose"

cd "$REPO_DIR" || exit 1

echo "📥 Updating repo..."
git fetch origin
git reset --hard origin/main

echo "🐳 Building & starting containers..."
$DOCKER_COMPOSE_CMD up -d --build --remove-orphans

echo "⚙️ Running migrations..."
$DOCKER_COMPOSE_CMD exec -T web python manage.py migrate --noinput

echo "📦 Collecting static files..."
$DOCKER_COMPOSE_CMD exec -T web python manage.py collectstatic --noinput


echo "✅ Done! Showing recent logs:"
$DOCKER_COMPOSE_CMD logs --tail=30 web
