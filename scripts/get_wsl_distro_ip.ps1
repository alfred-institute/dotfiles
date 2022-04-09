[CmdletBinding()]
param (
    [Parameter(Position=0,Mandatory)]
    [string]$Distro
)

return "$(wsl -d $Distro hostname -I)".trimend(" ")
