# InterBase Docker Container - Windows Server Core

This document describes how to use the Windows Server Core-based Docker container for InterBase 2020.

## Prerequisites

- Windows 10/11 Pro, Enterprise, or Windows Server 2019/2022 with Docker installed
- Docker Desktop configured for Windows containers (not Linux containers)
- Hyper-V enabled
- At least 8GB of available disk space

## Building the Windows Container

1. Switch Docker Desktop to Windows containers:
   - Right-click Docker Desktop tray icon
   - Select "Switch to Windows containers..."

2. Build the Windows InterBase container:
   ```powershell
   docker-compose build interbase-windows
   ```

## Running the Windows Container

Start the Windows InterBase container:

```powershell
docker-compose up -d interbase-windows
```

The container exposes InterBase on port 3051 (to avoid conflict with the Linux container on port 3050).

## Configuration

The Windows container uses the following configuration:

- **Base Image**: `mcr.microsoft.com/windows/servercore:ltsc2025`
- **InterBase Version**: 2020 (64-bit)
- **Default Port**: 3050 (mapped to 3051 on host)
- **Data Directory**: `C:\InterBase\data`
- **Installation Directory**: `C:\Program Files\Embarcadero\InterBase`

### Silent Installation Properties

The installation is configured via `resources/InterBase_2020_Windows/interbase_silent.properties` with:

- UTF8 as default character set
- Strong encryption enabled
- ODBC driver installed
- Service set to automatic startup

## Container Management

### Check container status:
```powershell
docker ps -a
```

### View container logs:
```powershell
docker logs interbase-server-windows
```

### Enter container shell:
```powershell
docker exec -it interbase-server-windows powershell
```

### Stop the container:
```powershell
docker-compose stop interbase-windows
```

### Remove the container and volumes:
```powershell
docker-compose down -v
```

## Connecting to InterBase

Default connection parameters:
- **Host**: localhost
- **Port**: 3051
- **Username**: sysdba
- **Password**: masterkey

### Using ISQL:
```powershell
docker exec -it interbase-server-windows powershell -Command "& 'C:\Program Files\Embarcadero\InterBase\bin\isql.exe' -user sysdba -password masterkey"
```

## Licensing

The container runs in evaluation mode by default. To use a licensed version:

1. Place your license file (`license.slip`) in the resources directory
2. Uncomment the `LICENSE_FILE` line in `interbase_silent.properties`
3. Rebuild the container

## Troubleshooting

### Container won't start
- Ensure Docker is in Windows container mode
- Check Windows features: Containers and Hyper-V must be enabled
- Verify sufficient disk space

### Connection issues
- Confirm port 3051 is not in use: `netstat -an | findstr :3051`
- Check Windows Firewall rules
- Verify InterBase service is running: `docker exec interbase-server-windows powershell -Command "Get-Service InterBase"`

### Build failures
- Ensure all files use Windows line endings (CRLF)
- Verify installer files are present in `resources/InterBase_2020_Windows/`
- Check Docker build output for specific errors

## Performance Considerations

- Windows containers have higher overhead than Linux containers
- Consider using process isolation mode for better performance on Windows Server
- Allocate sufficient memory to Docker Desktop (minimum 4GB recommended)

## Security Notes

- Change default passwords immediately in production
- Consider using Windows authentication when available
- Review and adjust firewall rules as needed
- Keep the base image updated with security patches