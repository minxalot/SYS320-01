$scrapedPage = Invoke-WebRequest "http://localhost/tobescraped.html"

$scrapedPage.Links | Select-Object outerText, href