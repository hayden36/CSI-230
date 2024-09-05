$folderpath="$PSScriptRoot\outfolder"
if (Test-Path $folderpath) {
    Write-Host "Already Exists"
} else {
    New-Item -Path $folderpath -ItemType Directory
}