[CmdletBinding()]
param (
    [Parameter()]
    [string]$Distro="Debian",

    [Parameter(Mandatory)]
    [string]$User,

    [Parameter()]
    [string]$Port=22
)

$Ip=./get_wsl_distro_ip.ps1 $Distro

ssh -p ${Port} ${User}`@${Ip}
