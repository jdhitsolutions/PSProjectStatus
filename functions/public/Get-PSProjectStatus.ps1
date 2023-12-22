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
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell Host $($Host.Name)"
    }
    Process {
        $json = Join-Path (Convert-Path $path) -ChildPath psproject.json
        if (Test-Path $json) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting project status from $json"
            $in = Get-Content -Path $json | ConvertFrom-Json
            $psproject = [PSProject]::new()

            #get property names from the class
            $properties = $psproject.PSObject.properties.name | Where-Object { $_ -ne "Age" }
            foreach ($property in $properties) {
                if ($property -eq 'RemoteRepository') {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Creating remote repository information"
                    $remote = @()
                    foreach ($repo in $in.RemoteRepository) {
                        $remote += [PSProjectRemote]::new($repo.name, $repo.url, $repo.mode)
                    }
                    $psproject.RemoteRepository = $remote

                }
                else {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Adding property $property"
                    $psproject.$property = $in.$property
                }
            }
            #The date time is stored as a UTC value so convert it to local
            $psproject.lastUpdate = $psproject.lastUpdate.ToLocalTime()
            #write the new object to the pipeline
            $psproject
        }
        else {
            Write-Warning "Can't find psproject.json in the specified location $(Convert-Path $path)."
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    }
}
