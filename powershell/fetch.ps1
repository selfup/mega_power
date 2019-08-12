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
    Write-Host "COULD NOT FIND PATHS - BREAKING OUT..." -ForegroundColor Red -BackgroundColor Black
    Break
}

if ($HOMEPATH -eq "") {
    Write-Host "FOUND USERPROFILE" -ForegroundColor White -BackgroundColor Magenta
    $ROOTPATH = $USERPROFILE 
}
else {
    Write-Host "FOUND HOME" -ForegroundColor White -BackgroundColor Magenta
    $ROOTPATH = $HOMEPATH
}

$MegaPath = "$ROOTPATH/.mega_power.mega.data.csv"
$PowerPath = "$ROOTPATH/.mega_power.power.data.csv"

$MegaFileThere = [System.IO.File]::Exists($MegaPath)
$PowerFileThere = [System.IO.File]::Exists($PowerPath)

if (($MegaFileThere) -And ($PowerFileThere)) {
    if (($args[0] -eq "--update") -Or ($args[0] -eq "-u")) {
        Write-Host "FOUND FILES BUT TOLD TO UPDATE with either -u or --update." -ForegroundColor Magenta -BackgroundColor Black
        Write-Host "FORCING AN UPDATE!" -ForegroundColor Magenta -BackgroundColor Black
    }
    else {
        Write-Host "FILES ALREADY EXIST. PLEASE USE --update TO UPDATE IF NEW DATA IS NEEDED" -ForegroundColor White -BackgroundColor Black
        
        Write-Output "--- OUTPUTTING LAST KNOWN RESULTS BELOW ---"
        Write-Output ""
        Write-Output "MEGA"
        Write-Output (Get-Content $MegaPath -Head 9)
        Write-Output ""
        Write-Output "POWER"
        Write-Output (Get-Content $PowerPath -Head 9)
        
        Break
    }

}

$PowerBallCsvUrl = 'https://data.ny.gov/api/views/d6yy-54nr/rows.csv?accessType=DOWNLOAD'
$MegaBallCsvUrl = 'https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD'

try {
    $PowerResponse = Invoke-WebRequest $PowerBallCsvUrl -Method 'GET' -UseBasicParsing
    Write-Host "FETCHED POWERBALL CSV DATA" -ForegroundColor Green
}
catch { 
    Write-Host "FAILED TO FETCH POWERBALL DATA, BREAKING OUT..." -ForegroundColor Red -BackgroundColor Black
    Break
}

try {
    $MegaResponse = Invoke-WebRequest $MegaBallCsvUrl -Method 'GET' -UseBasicParsing
    Write-Host "FETCHED MEGABALL CSV DATA" -ForegroundColor Green
}
catch {
    Write-Host "FAILED TO FETCH MEGABALL DATA, BREAKING OUT..." - -ForegroundColor Red -BackgroundColor Black
    Break
}

$PowerResponse.Content > $PowerPath
Write-Host "POWERBALL CSV WRITTEN TO: $PowerPath" -ForegroundColor Green -BackgroundColor Black

$MegaResponse.Content > $MegaPath
Write-Host "MEGAMILLIONS CSV WRITTEN TO: $MegaPath" -ForegroundColor Green -BackgroundColor Black

Write-Output "MEGA"
Write-Output (Get-Content $MegaPath -Head 9)

Write-Output ""

Write-Output "POWER"
Write-Output (Get-Content $PowerPath -Head 9)
