#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

$PowerResponse = Invoke-WebRequest 'https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD' -Method 'GET'
$MegaResponse = Invoke-WebRequest 'https://data.ny.gov/api/views/d6yy-54nr/rows.csv?accessType=DOWNLOAD' -Method 'GET'

$HOMEPATH = ""
$USERPROFILE = ""
$ROOTPATH = ""

try { $HOMEPATH = (Get-Item env:HOME).Value }
catch { Write-Host "CANNOT FIND HOME ENV" -ForegroundColor Yellow }

try { $USERPROFILE = (Get-Item env:USERPROFILE).Value }
catch { Write-Host "CANNOT FIND USERPROFILE ENV" -ForegroundColor Yellow }

if (!$HOMEPATH -And !$USERPROFILE) {
    Write-Host "COULD NOT FIND ROOTPATH PATHS EXITING..." -ForegroundColor Red
    exit
}

if ($HOMEPATH -eq "") {
    Write-Host "FOUND USERPROFILE PATH SETTING ROOTPATH TO $HOMEPATH" -ForegroundColor Blue
    $ROOTPATH = $USERPROFILE 
}
else {
    Write-Host "FOUND HOME PATH SETTING ROOTPATH TO $HOMEPATH" -ForegroundColor Blue
    $ROOTPATH = $HOMEPATH
}

$MegaPath = "$ROOTPATH/.mega_power.mega.data.csv"
$PowerPath = "$ROOTPATH/.mega_power.power.data.csv"

$PowerResponse.Content > $PowerPath
Write-Host "Powerball CSV written to $PowerPath" -ForegroundColor Green

$MegaResponse.Content > $MegaPath
Write-Host "MegaMillions CSV written to $MegaPath" -ForegroundColor Green
