function gatherClasses {
    $page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses.html

    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    $FullTable = @()
    for ($i=1; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName("td")

        $Times = $tds[5].innerText.split("-")
        
        $FullTable += [pscustomobject]@{ `
            "Class Code" = $tds[0].innerHtml; `
            "Title" = $tds[1].getElementsByTagName("a")[0].innerText; `
            "Days" = $tds[4].innerHtml; `
            "Time Start" = $Times[0]; `
            "Time End" = $Times[1]; `
            "Instructor" = $tds[6].getElementsByTagName("a")[0].innerText; `
            "Location" = $tds[9].innerHtml; `
         }   
    }

    return $FullTable
}


function daysTranslator {
    param($FullTable)
    for ($i=0; $i -lt $FullTable.length; $i++) {
        $Days = @()

      if ($FullTable[$i].Days -like "*M*") {$Days += "Monday"}
      if ($FullTable[$i].Days -like "T") {$Days += "Tuesday"}
      if ($FullTable[$i].Days -like "*T[WF]*") {$Days += "Tuesday"}
      if ($FullTable[$i].Days -like "*W*") {$Days += "Wednesday"}
      if ($FullTable[$i].Days -like "*TH*") {$Days += "Thursday"}
      if ($FullTable[$i].Days -like "*F*") {$Days += "Friday"}

      $FullTable[$i].Days = $Days
    }

    return $FullTable
}

