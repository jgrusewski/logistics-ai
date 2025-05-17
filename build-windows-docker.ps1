# PowerShell script to build Windows InterBase Docker image
# This script must be run on a Windows host with Docker Desktop in Windows container mode

# Ensure we're in Windows container mode
$dockerInfo = docker version --format '{{.Server.Os}}'
if ($dockerInfo -ne "windows") {
    Write-Error "Docker is not in Windows container mode. Please switch to Windows containers."
    Write-Host "Right-click Docker Desktop tray icon and select 'Switch to Windows containers...'"
    exit 1
}

# Build the Docker image
Write-Host "Building InterBase Windows Docker image..." -ForegroundColor Green
docker build -f Dockerfile.windows -t interbase-win2k25 .

if ($LASTEXITCODE -eq 0) {
    Write-Host "Build successful! Image tagged as 'interbase-win2k25'" -ForegroundColor Green
    Write-Host ""
    Write-Host "To run the container:" -ForegroundColor Yellow
    Write-Host "docker run -d -p 3051:3050 --name interbase-windows interbase-win2k25"
} else {
    Write-Error "Build failed with exit code $LASTEXITCODE"
}