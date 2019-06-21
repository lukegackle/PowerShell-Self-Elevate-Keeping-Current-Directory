Param(
    [string]$Loc
)

$Delay = 2

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltInRole] 'Administrator')
)
{
    Write-Host "Not elevated, restarting in $Delay seconds ..."
    $Loc = Get-Location
    Start-Sleep -Seconds $Delay

    $Arguments =  @(
        '-NoProfile',
        '-ExecutionPolicy Bypass',
        '-NoExit',
        '-File',
        "`"$($MyInvocation.MyCommand.Path)`"",
        "\`"$Loc\`""
    )
    Start-Process -FilePath PowerShell.exe -Verb RunAs -ArgumentList $Arguments
    Break
}
else
{
    Write-Host "Already elevated, exiting in $Delay seconds..."
    Start-Sleep -Seconds $Delay
}
if($Loc.Length -gt 1){
Set-Location $Loc.Substring(1,$Loc.Length-1)
}

#Your Script Here...
Read-Host "Done.."