$files=Get-ChildItem -Recurse -File
$files | Rename-Item -NewName {$_.name -replace ".csv", ".log"}
Get-ChildItem -Path "$PSScriptRoot/outfolder"