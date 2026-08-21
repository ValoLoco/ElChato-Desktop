#!/bin/bash
# ElChato-Desktop - Start ElChato Stack
# Starts Hermes + Paperclip + Postgres

set -e

echo "=== Starting ElChato Stack ==="

# Create data directories if they don't exist
mkdir -p /opt/elchato/hermes-data/{output,skills,sessions,logs}
mkdir -p /opt/elchato/paperclip-data/{audit,skills}
mkdir -p /opt/elchato/postgres-data

# Set permissions
chmod -R 777 /opt/elchato

# Start Docker compose (nested Docker)
cd /opt/elchato
docker compose up -d

# Wait for services
echo "⏳ Waiting for services..."
sleep 15

# Health checks
if curl -s http://localhost:3000/health > /dev/null; then
    echo "✅ Hermes healthy: http://localhost:3000"
else
    echo "⚠️  Hermes not responding yet"
fi

if curl -s http://localhost:3001/health > /dev/null; then
    echo "✅ Paperclip healthy: http://localhost:3001"
else
    echo "⚠️  Paperclip not responding yet"
fi

echo ""
echo "=== ElChato Stack Ready ==="
echo "Hermes: http://localhost:3000"
echo "Paperclip: http://localhost:3001"
echo "Desktop: http://localhost:6080"
echo ""
echo "To stop: docker compose down"
echo "To view logs: docker compose logs -f"

# Keep script running
tail -f /dev/null
