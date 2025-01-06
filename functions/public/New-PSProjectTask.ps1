Function New-PSProjectTask {
    [cmdletbinding(SupportsShouldProcess)]
    [alias("nptask")]
    [OutputType('None','psProjectTask')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the task description.")]
        [ValidateNotNullOrEmpty()]
        [string[]]$TaskDescription,
        [Parameter(HelpMessage = "Enter the parent path to the psproject.json file, e.g. c:\scripts\mymodule.")]
        [ValidateScript({ Test-Path $_ })]
        [alias("FullName")]
        [String]$Path = ".",
        [switch]$PassThru
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
    } #begin

    Process {
        $PSDefaultParameterValues["_verbose:block"] = "Process"
        $cPath = Convert-Path $Path
        $json = Join-Path $cPath -ChildPath psproject.json
        If (Test-Path -path $json) {
            _verbose ($strings.ProcessTasks -f $json)
            $in = Get-Content -Path $json | ConvertFrom-Json
            $in.Tasks+=$TaskDescription
            $in.LastUpdate = Get-Date

            $in | ConvertTo-Json | Out-File -FilePath $json
            if ($PassThru) {
                Get-PSProjectTask | where TaskDescription  -eq $TaskDescription
            }
        }
        else {
            Write-Warning $strings.missingJson
        }

    } #process

    End {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "End"
        _verbose $strings.Ending
    } #end

} #close New-PSProjectTask