#9 (Deliverable 1).
Write-Host "#9"
$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScraped.html

$scraped_page.Links.Count

#10 (Deliverable 2)
Write-Host "#10"
$scraped_page.Links

#11 (Deliverable 3)
Write-Host "#11"
$scraped_page.Links | Select-Object outerText, href

#12 (Deliverable 4)
Write-Host "#12"
$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText | Ft

$h2s

#13 (Deliverable 5)
Write-Host "#13"
$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { $_.getAttributeNode("class").Value -ilike "div-1"} | select innerText

$divs1