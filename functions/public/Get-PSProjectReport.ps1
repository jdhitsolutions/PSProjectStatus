#Get a top level view of your projects

Function Get-PSProjectReport {
    [cmdletbinding(DefaultParameterSetName="status")]
    [OutputType("PSProject")]
    Param(
        [Parameter(
            Mandatory,
            Position = 0,
            HelpMessage = "Specify the top level folder"
        )]
        [ValidateScript({Test-Path $_})]
        [string]$Path,
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
        [int]$NewerThan,
        [Parameter(
            ParameterSetName = "older",
            HelpMessage="Get projects where the age is older than X number of days"
        )]
        [int]$OlderThan
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing PSProjects under $Path "
        $All =  Get-ChildItem -Path C:\scripts -Directory | Get-PSProjectStatus -WarningAction SilentlyContinue
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Found $($All.count) projects"

        Switch ($PSCmdlet.ParameterSetName) {
            "Status" {
                if ($PSBoundParameters.ContainsKey("Status")) {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Filtering for $Status"
                    $results = $all.Where({$_.status -eq $status}) | Sort-Object -Property Age
                }
                else {
                    $results = $all  | Sort-Object -Property Age,Name
                }
            }
            "newer" {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Filtering for projects last updated within the last $NewerThan days"
                if ($PSBoundParameters.ContainsKey("Status")) {
                    $results = $all.Where({$_.status -eq $status -AND $_.Age.TotalDays -le $NewerThan}) | Sort-Object -Property Age
                }
                else {
                    $results =  $all.Where({$_.Age.TotalDays -le $NewerThan}) | Sort-Object -Property Age
                }
            }
            "older" {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Filtering for projects last updated in the more than $OlderThan days ago."
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
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Get-PSProjectReport