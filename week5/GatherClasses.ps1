function gatherClasses() {

    $page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses.html

    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    $FullTable = @()
    for ($i=1; $i -lt $trs.length; $i++) { # Going over every tr element
        # Get every td element of current tr element
        $tds = $trs[$i].getElementsByTagName("td")

        # Separate start time and end time from one time field
        $times = $tds[5].innerText -split "-"

        $FullTable += [PSCustomObject]@{"Class Code" = $tds[0].innerText; `
                                        "Title"  = $tds[1].innerText; `
                                        "Days"   = $tds[4].innerText; `
                                        "Time Start"  = $times[0]; `
                                        "Time End"  = $times[1]; `
                                        "Instructor"  = $tds[6].innerText; `
                                        "Location"  = $tds[9].innerText; `
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