[CmdletBinding()]
param (
    [Parameter()]
    [string]$Distro="Debian",

    [Parameter(Mandatory)]
    [string]$Port
)

$Ip=./get_wsl_distro_ip.ps1 $Distro

Write-Host "Forwarding 0.0.0.0:${Port} to ${Ip}:${Port}..."
netsh interface portproxy add v4tov4 listenport="${Port}" listenaddress="0.0.0.0" connectport="${Port}" connectaddress="${Ip}"
