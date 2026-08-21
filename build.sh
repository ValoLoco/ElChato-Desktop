#!/bin/bash
# ElChato-Desktop - Build Script
# Builds the Docker image locally

set -e

echo "=== Building ElChato-Desktop Docker Image ==="

# Build the image
docker build -t elchato-desktop:latest .

echo ""
echo "=== Build Complete ==="
echo "Image: elchato-desktop:latest"
echo ""
echo "To run:"
echo "  docker run -d --name elchato-desktop -p 6080:6080 -p 3000:3000 -p 3001:3001 -v elchato-desktop-data:/opt/elchato --privileged --shm-size=2g elchato-desktop:latest"
echo ""
echo "To test:"
echo "  docker run --rm -p 6080:6080 -p 3000:3000 -p 3001:3001 elchato-desktop:latest"
