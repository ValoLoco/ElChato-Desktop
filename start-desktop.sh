#!/bin/bash
# ElChato-Desktop - Start Desktop Environment
# Starts Xvfb + Hyprland/Fluxbox + noVNC

set -e

echo "=== Starting Omarchy Desktop ==="

# Start Xvfb (virtual framebuffer)
Xvfb :99 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset &
export DISPLAY=:99

# Wait for Xvfb to start
sleep 2

# Start Fluxbox (lightweight window manager - more stable than Hyprland in Xvfb)
fluxbox &

# Wait for window manager
sleep 2

# Start a terminal (kitty)
kitty -e bash -c "echo 'Welcome to ElChato-Desktop!'; echo ''; echo 'Hermes: http://localhost:3000'; echo 'Paperclip: http://localhost:3001'; exec bash" &

echo "✅ Desktop environment started"
echo "Access via noVNC: http://localhost:6080"

# Keep script running
wait
