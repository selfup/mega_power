#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

$PowerResponse = Invoke-WebRequest 'https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD' -Method 'GET'
$MegaResponse = Invoke-WebRequest 'https://data.ny.gov/api/views/d6yy-54nr/rows.csv?accessType=DOWNLOAD' -Method 'GET'

$HOMEPATH = ""
$USERPROFILE = ""
$ROOTPATH = ""

try { $HOMEPATH = (Get-Item env:HOME).Value }
catch { Write-Output "CANNOT FIND HOME ENV " }

try { $USERPROFILE = (Get-Item env:USERPROFILE).Value }
catch { Write-Output "CANNOT FIND USERPROFILE ENV" }

if (!$HOMEPATH -And !$USERPROFILE) {
    Write-Output "COULD NOT FIND ROOTPATH PATHS EXITING..."
    exit
}

if ($HOMEPATH -eq "") {
    Write-Output "FOUND USERPROFILE PATH SETTING ROOTPATH TO $HOMEPATH"
    $ROOTPATH = $USERPROFILE 
}
else {
    Write-Output "FOUND HOME PATH SETTING ROOTPATH TO $HOMEPATH"
    $ROOTPATH = $HOMEPATH
}

$MegaPath = "$ROOTPATH/.mega_power.mega.data.csv"
$PowerPath = "$ROOTPATH/.mega_power.power.data.csv"

$PowerResponse.Content > $PowerPath
Write-Output "Powerball CSV written to $PowerPath"

$MegaResponse.Content > $MegaPath
Write-Output "MegaMillions CSV written to $MegaPath"
