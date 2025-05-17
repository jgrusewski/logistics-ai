# Start InterBase Server

# Set InterBase environment variable
$env:INTERBASE = "C:\Program Files\Embarcadero\InterBase"

# Add InterBase bin to PATH
$env:PATH = "$env:INTERBASE\bin;$env:PATH"

# Check if InterBase service exists
$service = Get-Service -Name "InterBase" -ErrorAction SilentlyContinue

if ($service) {
    Write-Host "Starting InterBase service..."
    Start-Service -Name "InterBase"
    Write-Host "InterBase service started successfully."
} else {
    Write-Host "InterBase service not found. Starting InterBase server manually..."
    # Start InterBase server directly
    & "$env:INTERBASE\bin\ibserver.exe" -g
}

# Keep the container running
Write-Host "InterBase server is running. Press Ctrl+C to stop."
while ($true) {
    Start-Sleep -Seconds 60
}