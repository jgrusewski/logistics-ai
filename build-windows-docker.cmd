@echo off
REM Batch script to build Windows InterBase Docker image
REM This script must be run on a Windows host with Docker Desktop in Windows container mode

echo Checking Docker mode...
docker version --format "{{.Server.Os}}" > docker_mode.txt
set /p DOCKER_MODE=<docker_mode.txt
del docker_mode.txt

if not "%DOCKER_MODE%"=="windows" (
    echo Error: Docker is not in Windows container mode.
    echo Please right-click Docker Desktop tray icon and select "Switch to Windows containers..."
    exit /b 1
)

echo Building InterBase Windows Docker image...
docker build -f Dockerfile.windows -t interbase-win2k25 .

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Build successful! Image tagged as 'interbase-win2k25'
    echo.
    echo To run the container:
    echo docker run -d -p 3051:3050 --name interbase-windows interbase-win2k25
) else (
    echo Build failed with error code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)