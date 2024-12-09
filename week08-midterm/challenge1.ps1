function getIndicators {
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.5/IOC.html
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")
    
    $FullTable = @()

    for ($i = 1; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName("td")

        $FullTable += [pscustomobject]@{ `
        
            [string]"Pattern"         = $tds[0].innerHtml; `
                [string]"Description" = $tds[1].innerHtml;
        }
    }

    return $FullTable
}

# getIndicators