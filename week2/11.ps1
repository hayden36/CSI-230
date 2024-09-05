$files=Get-ChildItem -Recurse -Depth 0
$files | Rename_item -NewName {$_.name -replace ".ps1", ".log"}
Get-ChildItem