# ElChato-Desktop - Full Omarchy Desktop + ElChato Stack
# Browser-accessible via noVNC

FROM archlinux:base AS omarchy-desktop

# Install Omarchy desktop dependencies
RUN pacman -Syu --noconfirm \
    hyprland \
    waybar \
    kitty \
    fuzzel \
    dunst \
    polkit-kde-agent \
    xorg-server \
    xorg-xinit \
    xorg-xrandr \
    xorg-xrandr \
    xvfb \
    novnc \
    websockify \
    fluxbox \
    docker \
    docker-compose \
    python \
    nodejs \
    npm \
    git \
    curl \
    wget \
    ca-certificates \
    gnupg \
    supervisor \
    && pacman -Scc --noconfirm

# Install Omarchy (optional - can skip if you just want Hyprland)
# RUN curl -fsSL https://iso.omarchy.org/install.sh | bash

# Stage 2: ElChato stack
FROM omarchy-desktop AS elchato-desktop

# Set working directory
WORKDIR /opt/elchato

# Copy config files
COPY hermes-config.yaml /opt/elchato/hermes-config.yaml
COPY paperclip-config.yaml /opt/elchato/paperclip-config.yaml
COPY docker-compose.yml /opt/elchato/docker-compose.yml
COPY start-desktop.sh /opt/elchato/start-desktop.sh
COPY start-elchato.sh /opt/elchato/start-elchato.sh
COPY supervisor.conf /etc/supervisor/conf.d/elchato.conf

# Create data directories
RUN mkdir -p /opt/elchato/{hermes-data,paperclip-data,postgres-data} && \
    chmod -R 777 /opt/elchato

# Make scripts executable
RUN chmod +x /opt/elchato/*.sh

# Expose ports
# 6080: noVNC
# 3000: Hermes
# 3001: Paperclip
EXPOSE 6080 3000 3001

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:6080 || exit 1

# Default command: start supervisor (manages noVNC + ElChato stack)
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/elchato.conf", "-n"]
