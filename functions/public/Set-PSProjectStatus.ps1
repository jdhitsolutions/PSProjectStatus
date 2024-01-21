Function Set-PSProjectStatus {
    [CmdletBinding(SupportsShouldProcess)]
    [alias('spstat')]
    [OutputType("PSProject")]
    Param(
        [Parameter(ValueFromPipeline, HelpMessage = "Specify a PSProject object")]
        [ValidateNotNullOrEmpty()]
        [object]$InputObject = (Get-PSProjectStatus -Path .),

        [Parameter(HelpMessage = "What is the project name?")]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        [Parameter(HelpMessage = "When was the project last worked on?")]
        [ValidateNotNullOrEmpty()]
        [alias("date")]
        [DateTime]$LastUpdate = $(Get-Date),

        [Parameter(HelpMessage = "What are the remaining tasks?")]
        [string[]]$Tasks,

        [Parameter(HelpMessage = "Concatenate tasks")]
        [alias("add")]
        [Switch]$Concatenate,

        [Parameter(HelpMessage = "What tags do you want to assign to this project?")]
        [string[]]$Tags,

        [Parameter(HelpMessage = "What is the project status?")]
        [ValidateNotNullOrEmpty()]
        [PSProjectStatus]$Status,

        [Parameter(HelpMessage = "What is the project version?")]
        [ValidateNotNullOrEmpty()]
        [alias("version")]
        [version]$ProjectVersion,

        [Parameter(HelpMessage = "Enter an optional comment. This could be git tag, or an indication about the type of project.")]
        [String]$Comment
    )

    Begin {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "Begin"

        _verbose -message $strings.Starting
        if ($MyInvocation.CommandOrigin -eq "Runspace") {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingModule -f $PSProjectStatusModule)
        }
    } #begin
    Process {
        $PSDefaultParameterValues["_verbose:block"] = "Process"
        _verbose ($strings.Updating -f $InputObject.Name)

        $properties = "Name", "Status", "ProjectVersion", "Comment"
        foreach ($property in $properties) {
            if ($PSBoundParameters.ContainsKey($property)) {
                _verbose ($strings.UpdateProperty -f $Property)
                $InputObject.$property = $PSBoundParameters[$property]
            }
        }
        #11/28/2023 - always update the LastUpdate property -JDH
        _verbose ($strings.Updating -f "LastUpdate")
        if ($PSBoundParameters.ContainsKey("LastUpdate")) {
            $InputObject.LastUpdate = $PSBoundParameters["LastUpdate"]
        }
        else {
            $InputObject.LastUpdate = $LastUpdate
        }
        #12/27/2023 Add support for tags
        if ($PSBoundParameters.ContainsKey("Tags")) {
            _verbose ($strings.Updating -f "Tags")
            $InputObject.Tags = $PSBoundParameters["Tags"]
        }
        elseif ($null -eq $InputObject.Tags) {
            #1/21/2024 Insert an empty array if the tags property is null
            $InputObject.Tags =@()
        }

        if ($PSBoundParameters.ContainsKey("Tasks")) {
            if ($Concatenate) {
                _verbose $strings.appendTasks
                $InputObject.Tasks += $PSBoundParameters["Tasks"]
            }
            else {
                _verbose $strings.ReplaceTasks
                $InputObject.Tasks = $PSBoundParameters["Tasks"]
            }
        }
        elseif ($null -eq $InputObject.Tasks) {
            #1/21/2024 Insert an empty array if the tasks property is null
            $InputObject.Tasks =@()
        }
        If (Test-Path .git) {
            _verbose $strings.GetGitBranch
            $InputObject.GitBranch = git branch --show-current
            #get git remote
            _verbose $strings.GetGitRemote
            $rm = _getRemote
            $rm | Out-String | Write-Debug
            if ($null -eq $rm) {
                $rm = @()
            }
            $InputObject.RemoteRepository = $rm
        }

        $InputObject.UpdateUser = "$([system.environment]::UserDomainName)\$([System.Environment]::Username)"
        $InputObject.Computername = [System.Environment]::MachineName
        if ($PSCmdlet.ShouldProcess($InputObject.Name)) {
            $InputObject
            _verbose ($strings.UsingPath -f $InputObject.Path)
            $InputObject.Save()
        }
    } #process
    End {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "End"
        _verbose $strings.Ending
    } #end
}
