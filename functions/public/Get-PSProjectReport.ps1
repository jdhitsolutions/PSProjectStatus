#Get a top level view of your projects

Function Get-PSProjectReport {
    [CmdletBinding(DefaultParameterSetName="status")]
    [OutputType("PSProject")]
    Param(
        [Parameter(
            Mandatory,
            Position = 0,
            HelpMessage = "Specify the top level folder"
        )]
        [ValidateScript({Test-Path $_})]
        [String]$Path,

        [Parameter(
            ParameterSetName = "status",
            HelpMessage = "Filter projects by status"
        )]
        [Parameter(ParameterSetName = "newer")]
        [Parameter(ParameterSetName = "older")]
        [PSProjectStatus]$Status,
        [Parameter(
            ParameterSetName = "newer",
            HelpMessage="Get projects where the age is newer than X number of days"
        )]
        [Int]$NewerThan,

        [Parameter(
            ParameterSetName = "older",
            HelpMessage="Get projects where the age is older than X number of days"
        )]
        [Int]$OlderThan,

        [Parameter(HelpMessage = "Get projects with a specific tag")]
        [string]$Tag
    )

    Begin {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "Begin"
        $PSDefaultParameterValues["_verbose:ANSI"] = "[1;38;5;213m"
        _verbose -message $strings.Starting
        _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
        _verbose -message ($strings.UsingHost -f $host.Name)
        _verbose -message ($strings.UsingModule -f $PSProjectStatusModule)
    } #begin

    Process {
        $PSDefaultParameterValues["_verbose:block"] = "Process"
        _verbose -message ($strings.ProcessingPath -f $Path)
        $All =  Get-ChildItem -Path $Path -Directory | Get-PSProjectStatus -WarningAction SilentlyContinue
        if ($Tag) {
            _verbose -message ($strings.FilterTag -f $Tag)
            $All = $All | Where-Object {$_.Tags -contains $Tag}
        }
        _verbose -message ($strings.FoundProjects -f $All.Count)
        Switch ($PSCmdlet.ParameterSetName) {
            "Status" {
                if ($PSBoundParameters.ContainsKey("Status")) {
                    _verbose -message ($strings.FilterStatus -f $status)
                    $results = $all.Where({$_.status -eq $status}) | Sort-Object -Property Age
                }
                else {
                    $results = $all  | Sort-Object -Property Age,Name
                }
            }
            "newer" {
                _verbose -message ($strings.FilterNewer -f $NewerThan)
                if ($PSBoundParameters.ContainsKey("Status")) {
                    $results = $all.Where({$_.status -eq $status -AND $_.Age.TotalDays -le $NewerThan}) | Sort-Object -Property Age
                }
                else {
                    $results =  $all.Where({$_.Age.TotalDays -le $NewerThan}) | Sort-Object -Property Age
                }
            }
            "older" {
                _verbose -message ($strings.FilterOlder -f $OlderThan)
                if ($PSBoundParameters.ContainsKey("Status")) {
                    $results = $all.Where({$_.status -eq $status -AND $_.Age.TotalDays -ge $OlderThan}) | Sort-Object -Property Age
                }
                else {
                    $results =  $all.Where({$_.Age.TotalDays -ge $OlderThan}) | Sort-Object -Property Age
                }
            }
        } #switch ParameterSetName
        #write results to the pipeline
        $results
    } #process

    End {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "End"
        $PSDefaultParameterValues["_verbose:ANSI"] = "[1;38;5;213m"
        _verbose $strings.Ending
    } #end

} #close Get-PSProjectReport
