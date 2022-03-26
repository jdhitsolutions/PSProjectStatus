Function Get-PSProjectStatus {
    [cmdletbinding()]
    [alias("gpstat")]
    [OutputType("PSProject")]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the parent path to the psproject.json file, e.g. c:\scripts\mymodule.")]
        [ValidateScript({ Test-Path $_ })]
        [alias("fullname")]
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
                if ($property -eq 'RemoteRepository') {
                    Write-Verbose "Creating remote repository information"
                    $remote = @()
                    foreach ($repo in $in.RemoteRepository) {
                        $remote += [PSProjectRemote]::new($repo.name, $repo.url, $repo.mode)
                    }
                    $psproject.RemoteRepository = $remote

                }
                else {
                    Write-Verbose "Adding property $property"
                    $psproject.$property = $in.$property
                }
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
