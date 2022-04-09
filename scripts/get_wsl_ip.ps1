[CmdletBinding()]
param (
    [Parameter()]
    [string]$Distro="Debian",
)

return "$(wsl -d $Distro hostname -I)".trimend(" ")
