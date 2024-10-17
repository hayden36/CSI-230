function getTable {
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.5/IOC.html
    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")
    
    $FullTable = @()

    for ($i = 0; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName("td")

        $FullTable += [pscustomobject]@{ `
        
            "Pattern"         = $tds[0].innerHtml; `
                "Description" = $tds[1].innerHtml;
        }
    }

    return $FullTable
}

getTable