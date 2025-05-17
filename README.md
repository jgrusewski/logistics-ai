# Logistics AI - InterBase Docker Containers

This repository contains Docker configurations for running InterBase 2020 database servers in containerized environments for logistics AI applications. It supports both Linux and Windows containers.

## Features

- InterBase 2020 database server
- Support for both Linux (Ubuntu) and Windows Server Core
- Automated builds via GitHub Actions
- X11 and non-X11 Linux variants
- Configured for production use
- Downloads InterBase packages from Azure blob storage during build

## Available Images

1. **Linux with X11 support**: For development with GUI tools
2. **Linux without X11**: For production/headless deployments
3. **Windows Server Core**: For Windows-native deployments

## Quick Start

### Linux Container

```bash
# Build and run the Linux container
docker-compose up -d interbase

# Access the container
docker exec -it interbase-server isql -user sysdba -password masterkey
```

### Windows Container (requires Windows host)

```powershell
# Build the Windows container
docker build -f Dockerfile.windows -t interbase-win2k25 .

# Run the Windows container
docker run -d -p 3051:3050 --name interbase-windows interbase-win2k25
```

## GitHub Actions

This repository includes automated builds:

- **Linux containers**: Built on every push to main
- **Windows container**: Built on Windows Server 2022 runners

To use automated builds, configure these secrets in your repository:
- `DOCKER_USERNAME`: Your Docker Hub username
- `DOCKER_TOKEN`: Your Docker Hub access token

## Documentation

- [Docker Setup Guide](README-Docker.md)
- [Windows Container Guide](README-Docker-Windows.md)

## Requirements

- Docker Desktop (Linux/macOS/Windows)
- For Windows containers: Windows 10/11 Pro or Windows Server
- InterBase license (for production use)

## License

The Docker configurations are provided as-is. InterBase is proprietary software by Embarcadero Technologies.