Function Get-PSProjectStatus {
    [cmdletbinding()]
    Param(
        [Parameter(Position = 0, HelpMessage = "Enter the path to the psproject.json file")]
        [ValidateScript({ Test-Path $_ })]
        [string]$Path = "."
    )

    $json = Join-Path (Convert-Path $path) -ChildPath psproject.json
    if (Test-Path $json) {
        Write-Verbose "Getting project status from $json"
        $in = Get-Content -Path $json | ConvertFrom-Json
        $psproject = [PSProject]::new()
        #get property names
        $properties = $psproject.psobject.properties.name | Where-Object {$_ -ne "Age"}
        foreach ($property in $properties) {
            Write-Verbose "Adding property $property"
            $psproject.$property = $in.$property
        }
        #datetime is stored as a UTC value so convert it to local
        $psproject.lastUpdate = $psproject.lastUpdate.tolocalTime()
        #write the new object to the pipeline
        $psproject
    }
    else {
        Write-Warning "Can't find psproject.json in the specified location $(Convert-Path $path)."
    }

}
