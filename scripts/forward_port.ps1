[CmdletBinding()]
param (
    [Parameter(Position=0,Mandatory)]
    [string]$Distro,

    [Parameter(Position=1,Mandatory)]
    [string]$Port
)
$Ip="$(wsl -d $Distro hostname -I)".trimend(" ")

Write-Host "Forwarding 0.0.0.0:${Port} to ${Ip}:${Port}..."
netsh interface portproxy add v4tov4 listenport="${Port}" listenaddress="0.0.0.0" connectport="${Port}" connectaddress="${Ip}"
