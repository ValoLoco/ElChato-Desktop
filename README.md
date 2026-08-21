# ElChato-Desktop

**Full Omarchy desktop (Hyprland/Fluxbox + terminal) + ElChato stack (Hermes + Paperclip + Postgres) in Docker. Browser-accessible via noVNC.**

## Quick Start

### One-Command Deploy

```bash
docker run -d \
  --name elchato-desktop \
  -p 6080:6080 \
  -p 3000:3000 \
  -p 3001:3001 \
  -v elchato-desktop-data:/opt/elchato \
  --privileged \
  --shm-size=2g \
  ghcr.io/valoloco/elchato-desktop:latest
```

### Access

- **Desktop (noVNC)**: http://localhost:6080
- **Hermes Agent**: http://localhost:3000
- **Paperclip**: http://localhost:3001

## What's Included

### Omarchy Desktop
- **Fluxbox** window manager (lightweight, stable in Docker)
- **Kitty** terminal emulator
- **Xvfb** virtual framebuffer (1920x1080)
- **noVNC** browser-based VNC client
- Full Arch Linux environment

### ElChato Stack
- **Hermes Agent** with:
  - Browser Use mode (efficient automation)
  - Skill compounding (auto-saves workflows)
  - Docker sandbox (secure execution)
- **Paperclip** with:
  - Org chart & budgets
  - Governance & approvals
  - Skill catalog sync
- **Postgres 16** for persistent storage

## Features

### 🖥️ Desktop Environment
- Browser-accessible desktop (noVNC)
- Terminal with direct access to Hermes/Paperclip
- Full Arch Linux package manager (pacman)
- Install additional apps as needed

### 🔒 Security
- Docker hardening (cap-drop ALL, minimal cap-add)
- pids_limit: 256
- tmpfs for /tmp, /var/tmp, /run
- no-new-privileges security option
- `--privileged` flag required for nested Docker

### 🧠 Skill Compounding
- Hermes auto-saves successful workflows as skills
- Skills sync to Paperclip catalog
- Guard prompts before agent writes new skills

### 🌐 Browser Use Mode
- Replaces 12 browser tools with one script-driven tool
- Cuts tokens 48-66% with no accuracy drop
- Auto-detects login walls and 2FA

## Data Layout

```
/opt/elchato/
├── hermes-data/
│   ├── output/        # Generated files
│   ├── skills/        # Auto-saved skills
│   ├── sessions/      # Persistent sessions
│   └── logs/          # Redacted logs
├── paperclip-data/
│   ├── audit/         # Action audit trail
│   └── skills/        # Company skill catalog
└── postgres-data/     # Paperclip DB
```

## Configuration

### Hermes Config
Edit `hermes-config.yaml` and restart:
```bash
docker restart elchato-desktop
```

### Paperclip Config
Edit `paperclip-config.yaml` and restart:
```bash
docker restart elchato-desktop
```

### Environment Variables

Set these in your shell before running:
```bash
export OPENROUTER_API_KEY="your-key-here"
export GITHUB_TOKEN="your-token-here"
```

## Build from Source

```bash
docker build -t elchato-desktop:latest .
```

## Troubleshooting

### Desktop not loading
```bash
docker logs elchato-desktop
docker exec -it elchato-desktop bash
# Check if Xvfb and noVNC are running
ps aux | grep -E 'Xvfb|websockify'
```

### Services not starting
```bash
docker compose logs -f
```

### Reset everything
```bash
docker stop elchato-desktop
docker rm elchato-desktop
docker volume rm elchato-desktop-data
# Then run the one-command deploy again
```

### Check health
```bash
curl http://localhost:6080  # noVNC
curl http://localhost:3000/health  # Hermes
curl http://localhost:3001/health  # Paperclip
```

### Performance issues
- Increase `--shm-size` (e.g., `--shm-size=4g`)
- Reduce resolution in `supervisor.conf` (e.g., 1280x720)
- Use a lighter window manager (Fluxbox is already lightweight)

## Costs

- **Docker**: Free (runs locally)
- **Model inference**: Use OpenRouter (pay-per-token) or local models
- **Storage**: Depends on your Docker volume size (~10-20GB typical)

## Next Steps

1. Open noVNC: http://localhost:6080
2. You'll see a desktop with a terminal
3. In the terminal, access Hermes/Paperclip:
   - Hermes: http://localhost:3000
   - Paperclip: http://localhost:3001
4. Configure API keys in Hermes
5. Set up your company in Paperclip

## License

MIT
