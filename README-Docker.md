# InterBase 2020 Docker Setup

This Docker configuration runs InterBase 2020 Server on Ubuntu 20.04.

## Prerequisites

- Docker Desktop for Mac with Rosetta emulation enabled
- InterBase 2020 Linux installation files in `resources/InterBase_2020_Linux/`

## Architecture Note

On Apple Silicon (M1/M2) Macs, this container runs using x86_64 emulation via Rosetta. This is required because InterBase 2020 is only available for x86_64 architecture.

To enable Rosetta in Docker Desktop:
1. Open Docker Desktop preferences
2. Go to "Features in development"
3. Enable "Use Rosetta for x86/amd64 emulation on Apple Silicon"

## Build and Run

### Using Docker Compose (Recommended)

```bash
# Build and start the container
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the container
docker-compose down
```

### Using Docker directly

```bash
# Build the image for x86_64 platform
docker build --platform linux/amd64 -t interbase:2020 .

# Run the container
docker run -d \
  --platform linux/amd64 \
  --name interbase-server \
  -p 3050:3050 \
  interbase:2020
```

## Configuration

- Default port: 3050
- Default credentials:
  - Username: sysdba
  - Password: masterkey

## Volumes

The docker-compose.yml creates a named volume `interbase-data` to persist database files.

## Notes

- The installation runs in console mode using Xvfb to satisfy X Window System requirements
- The container includes OpenJDK 8 for the License Manager
- The server starts automatically when the container runs
- On arm64 architecture (Apple Silicon), the container uses Rosetta emulation

## Troubleshooting

If the installation fails:
1. Check the installation logs: `docker logs interbase-server`
2. Ensure the installation files have execute permissions
3. Verify that all required installation files are present
4. On Apple Silicon, ensure Rosetta is enabled in Docker Desktop

## Connection Example

Connect from host machine:
```
isql localhost:employee -user sysdba -password masterkey
```