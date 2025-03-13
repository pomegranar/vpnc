
# Define the path for the vpnc.conf file
$vpncConfigPath = "C:\Program Files (x86)\Cisco\Cisco Secure Client\vpnc.conf"

# Prompt for NetID and password
$NETID = Read-Host "Enter your NetID"
$PASSWORD = Read-Host "Enter your password" -AsSecureString

# Convert the secure password to plain text for saving
$PASSWORDPlainText = (New-Object PSCredential "N/A", $PASSWORD).GetNetworkCredential().Password

# Create the directory if it doesn't exist
$directoryPath = Split-Path -Path $vpncConfigPath
if (!(Test-Path $directoryPath)) {
    New-Item -ItemType Directory -Path $directoryPath -Force
}

# Save credentials to vpnc.conf
$content = @(
    "connect vpn.duke.edu"
    "2"
    $NETID
    $PASSWORDPlainText
    "1"
)
Set-Content -Path $vpncConfigPath -Value $content -Force

Write-Host "Saved credentials to $vpncConfigPath"

# Set file permissions to read-only for the current user
$acl = Get-Acl $vpncConfigPath
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Users", "Read", "None", "None", "Deny")
$acl.SetAccessRule($rule)
Set-Acl $vpncConfigPath $acl


# Define PowerShell functions equivalent to the Bash aliases
function vpnc {
    # Run the VPN command with the config file
    Start-Process -FilePath "C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe" -ArgumentList "-s", $vpncConfigPath
}

function vpnd {
    # Disconnect the VPN
    Start-Process -FilePath "C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe" -ArgumentList "disconnect"
}

function vpni {
    # Run the VPN interactively
    Start-Process -FilePath "C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe"
}

# Add these functions to your PowerShell profile
$profilePath = $PROFILE
if (!(Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force
}

Add-Content -Path $profilePath -Value "function vpnc { Start-Process -FilePath 'C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe' -ArgumentList '-s', 'C:\Program Files (x86)\Cisco\Cisco Secure Client\vpnc.conf' }"
Add-Content -Path $profilePath -Value "function vpnd { Start-Process -FilePath 'C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe' -ArgumentList 'disconnect' }"
Add-Content -Path $profilePath -Value "function vpni { Start-Process -FilePath 'C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe' }"

Write-Host "Added functions 'vpnc', 'vpnd', 'vpni' to your PowerShell profile"

# Reload PowerShell profile
. $PROFILE

