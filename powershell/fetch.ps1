#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

$HOMEPATH = ""
$USERPROFILE = ""
$ROOTPATH = ""

try { $HOMEPATH = (Get-Item env:HOME).Value }
catch { Write-Host "CANNOT FIND HOME ENV" -ForegroundColor Yellow }

try { $USERPROFILE = (Get-Item env:USERPROFILE).Value }
catch { Write-Host "CANNOT FIND USERPROFILE ENV" -ForegroundColor Yellow }

if (($HOMEPATH -eq "") -And ($USERPROFILE -eq "")) {
    Write-Host "COULD NOT FIND PATHS - BREAKING OUT..." -ForegroundColor Red
    Break
}

if ($HOMEPATH -eq "") {
    Write-Host "FOUND USERPROFILE" -ForegroundColor Blue
    $ROOTPATH = $USERPROFILE 
}
else {
    Write-Host "FOUND HOME" -ForegroundColor Blue
    $ROOTPATH = $HOMEPATH
}

$MegaPath = "$ROOTPATH/.mega_power.mega.data.csv"
$PowerPath = "$ROOTPATH/.mega_power.power.data.csv"

$MegaFileThere = [System.IO.File]::Exists($MegaPath)
$PowerFileThere = [System.IO.File]::Exists($PowerPath)

if (($MegaFileThere) -And ($PowerFileThere)) {
    if (($args[0] -eq "--update") -Or ($args[0] -eq "-u")) {
        Write-Host "FOUND FILES BUT TOLD TO UPDATE with either -u or --update." -ForegroundColor Magenta
        Write-Host "FORCING AN UPDATE!" -ForegroundColor Magenta
    }
    else {
        Write-Host "FILES ALREADY EXIST. PLEASE USE --update TO UPDATE. BREAKING OUT..." -ForegroundColor Red
        Break
    }

}

$PowerBallCsvUrl = 'https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD'
$MegaBallCsvUrl = 'https://data.ny.gov/api/views/d6yy-54nr/rows.csv?accessType=DOWNLOAD'

try {
    $PowerResponse = Invoke-WebRequest $PowerBallCsvUrl -Method 'GET'
    Write-Host "FETCHED POWERBALL CSV DATA" -ForegroundColor Green
}
catch { 
    Write-Host "FAILED TO FETCH POWERBALL DATA, BREAKING OUT..." - -ForegroundColor Red
    Break
}

try {
    $MegaResponse = Invoke-WebRequest $MegaBallCsvUrl -Method 'GET'
    Write-Host "FETCHED MEGABALL CSV DATA" -ForegroundColor Green
}
catch {
    Write-Host "FAILED TO FETCH MEGABALL DATA, BREAKING OUT..." - -ForegroundColor Red
    Break
}

$PowerResponse.Content > $PowerPath
Write-Host "POWERBALL CSV WRITTEN TO: $PowerPath" -ForegroundColor Green

$MegaResponse.Content > $MegaPath
Write-Host "MEGAMILLIONS CSV WRITTEN TO: $MegaPath" -ForegroundColor Green
