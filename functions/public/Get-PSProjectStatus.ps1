Function Get-PSProjectStatus {
    [CmdletBinding()]
    [alias("gpstat")]
    [OutputType("PSProject")]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the parent path to the psproject.json file, e.g. c:\scripts\mymodule.")]
        [ValidateScript({ Test-Path $_ })]
        [alias("FullName")]
        [String]$Path = "."
    )

    Begin {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "Begin"
        _verbose -message $strings.Starting

        if ($MyInvocation.CommandOrigin -eq "Runspace") {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
            _verbose -message ($strings.UsingModule -f $PSProjectStatusModule)
        }
    }
    Process {
        $PSDefaultParameterValues["_verbose:block"] = "Process"
        $json = Join-Path (Convert-Path $path) -ChildPath psproject.json
        if (Test-Path $json) {
            _verbose -message ($strings.GetStatus -f $json)
            $in = Get-Content -Path $json | ConvertFrom-Json
            $psproject = [PSProject]::new()

            #get property names from the class
            $properties = $psproject.PSObject.properties.name | Where-Object { $_ -notMatch "Age|Path" }
            foreach ($property in $properties) {
                if ($property -eq 'RemoteRepository') {
                    Write-Debug $strings.RemoteRepositoryInfo
                    $remote = @()
                    foreach ($repo in $in.RemoteRepository) {
                        $remote += [PSProjectRemote]::new($repo.name, $repo.url, $repo.mode)
                    }
                    $psproject.RemoteRepository = $remote
                }
                else {
                    Write-Debug ($strings.addProperty -f $property)
                    $psproject.$property = $in.$property
                }
            }
            $psproject.Path = Split-Path $json
            #The date time is stored as a UTC value so convert it to local
            $psproject.lastUpdate = $psproject.lastUpdate.ToLocalTime()
            #write the new object to the pipeline
            $psproject
        }
        else {
            Write-Warning $($strings.missingJson -f (Convert-Path $path))
        }
    } #process

    End {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "End"
        _verbose $strings.Ending
    }
}
