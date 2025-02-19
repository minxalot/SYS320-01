$scrapedPage = Invoke-WebRequest "http://localhost/tobescraped.html"

$divs1 = $scrapedPage.ParsedHtml.body.getElementsByTagName("div") | where { `
    $_.className -eq "div-green" } | select innerText

$divs1