function gatherClasses() {

    $page = Invoke-WebRequest -TimeoutSec 2 http://localhost/IOC.html

    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    $FullTable = @()
    for ($i=1; $i -lt $trs.length; $i++) { # Going over every tr element
        # Get every td element of current tr element
        $tds = $trs[$i].getElementsByTagName("td")

        $FullTable += [PSCustomObject]@{"Pattern" = $tds[0].innerText; `
                                        "Description"  = $tds[1].innerText; `
                                        }
    }
    return $FullTable
}

function daysTranslator($FullTable) {
    
    for($i=0; $i -lt $FullTable.length; $i++) {

    $Days = @()

    # If you see "M" -> Monday
    if($FullTable[$i].Days -ilike "M") { $Days += "Monday" }

    # If you see "T" followed by T, W, or F -> Tuesday
    if($FullTable[$i].Days -ilike "*T[THWF]*") { $Days += "Tuesday" }
    # If you only see "T" -> Tuesday
    elseif($FullTable[$i].Days -ilike "T") { $Days += "Tuesday" }

    # If you see "W" -> Wednesday
    if($FullTable[$i].Days -ilike "W") { $Days += "Wednesday" }

    # If you see "TH" -> Thursday
    if($FullTable[$i].Days -ilike "TH") { $Days += "Thursday" }

    # If you see "F" -> Friday
    if($FullTable[$i].Days -ilike "F") { $Days += "Friday" }

    # Make the switch
    $FullTable[$i].Days = $Days

    }

    return $FullTable

}

# i didn't have time to finish the rest of this, was not feeling well this week