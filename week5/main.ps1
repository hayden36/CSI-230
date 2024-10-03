. (Join-Path "C:/Users/champuser/CSI-230/week5" ScrapingChamplainClasses.ps1)
$classes = gatherClasses

daysTranslator -FullTable $classes


# i.
#$classes | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | ` 
            Where {$_."Instructor" -ilike "*Furkan*"} | Ft

# ii.
#$classes | Where-Object { ($_.Location -eq "JOYC 310") -and ($_.days -contains "Monday")} | `
            Sort-Object "Time Start" | Ft "Time Start", "Time End", "Class Code"


# iii.
$ITSInstructors = $classes | Where-Object {($_."Class Code" -ilike "SYS*") -or `
                           ($_."Class Code" -ilike "NET*") -or `
                           ($_."Class Code" -ilike "sec*") -or `
                           ($_."Class Code" -ilike "FOR*") -or `
                           ($_."Class Code" -ilike "csi*") -or `
                           ($_."Class Code" -ilike "dat*")} `
                            | Sort-Object "Instructor" -Unique 

#$ITSInstructors

$classes | Where {$_.Instructor -in $ITSInstructors.Instructor} `
            | Group-Object "Instructor" | Select-Object Count,Name  | Sort-Object Count -Descending | Ft