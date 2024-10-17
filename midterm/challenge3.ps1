. (Join-Path "C:\Users\champuser\CSI-230\midterm" challenge1.ps1)
. (Join-Path "C:\Users\champuser\CSI-230\midterm" challenge2.ps1)

$allLogs = obtainLogs

$indicators = getIndicators
$filteredLogs = @()

# for each log, check if the page contains a `pattern` from the indicators
# for ($i = 0; $i -lt $allLogs.Length; $i++) {
#     for ($j = 0; $j -lt $indicators.Length; $j++) {
#         Write-Host "looking for " $indicators[$j].Pattern

#         $b = $indicators[$j].Pattern
#         if ($b -ilike "*$allLogs[$i].Page*") {
#             Write-Host "matched for" $b
#             $filteredLogs += $allLogs[$i]
#         }
#     }
# }

for ($j = 0; $j -lt $indicators.Length; $j++) {
    $b = $indicators[$j]."Pattern"
    $filteredLogs += $allLogs | Where-Object { $_."Page" -ilike "*$b*" } 
    # $filteredLogs += $allLogs | Where-Object { $_.Page -ilike "*.bash*" }
}


$filteredLogs | Format-Table -AutoSize -Wrap