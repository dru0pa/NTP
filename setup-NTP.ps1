# This script configures NTP on a Windows server.

# Requires administrator privileges.

# Prompt the user for the NTP server address.
$ntpServer = Read-Host "Enter the NTP server address (e.g., pool.ntp.org, time.google.com)"

# Validate the input.
while ([string]::IsNullOrWhiteSpace($ntpServer)) {
  $ntpServer = Read-Host "NTP server cannot be empty. Please enter a valid address"
}

# Stop the Windows Time service.
Stop-Service w32time

# Configure the NTP server.
w32tm /config /manualpeerlist:"$ntpServer" /syncfromflags:MANUALPEERLIST

# Start the Windows Time service.
Start-Service w32time

# Force a time sync.
w32tm /resync

# Display the current time settings.
w32tm /query /configuration
