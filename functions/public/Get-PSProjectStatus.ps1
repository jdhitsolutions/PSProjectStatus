Function Get-PSProjectStatus {
    [cmdletbinding()]
    [OutputType("PSProject")]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the parent path to the psproject.json file, e.g. c:\scripts\mymodule.")]
        [ValidateScript({ Test-Path $_ })]
        [string]$Path = "."
    )

    Begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand)"
    }
    Process {


        $json = Join-Path (Convert-Path $path) -ChildPath psproject.json
        if (Test-Path $json) {
            Write-Verbose "Getting project status from $json"
            $in = Get-Content -Path $json | ConvertFrom-Json
            $psproject = [PSProject]::new()

            #get property names from the class
            $properties = $psproject.psobject.properties.name | Where-Object { $_ -ne "Age" }
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
    } #process

    End {
        Write-Verbose "Ending $($MyInvocation.MyCommand)"
    }
}
