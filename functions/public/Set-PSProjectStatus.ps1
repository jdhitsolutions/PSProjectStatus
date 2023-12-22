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
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell Host $($Host.Name)"
    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Updating $($InputObject.name)"

        $properties = "Name", "Status", "ProjectVersion", "Comment"
        foreach ($property in $properties) {
            if ($PSBoundParameters.ContainsKey($property)) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Updating $property"
                $InputObject.$property = $PSBoundParameters[$property]
            }
        }
        #11/28/2023 - always update the LastUpdate property -JDH
        Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Updating LastUpdate"
        if ($PSBoundParameters.ContainsKey("LastUpdate")) {
            $InputObject.LastUpdate = $PSBoundParameters["LastUpdate"]
        }
        else {
            $InputObject.LastUpdate = $LastUpdate
        }
        if ($PSBoundParameters.ContainsKey("Tasks")) {
            if ($Concatenate) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Appending tasks"
                $InputObject.Tasks += $PSBoundParameters["Tasks"]
            }
            else {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Replacing tasks"
                $InputObject.Tasks = $PSBoundParameters["Tasks"]
            }
        }
        If (Test-Path .git) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting git branch"
            $InputObject.GitBranch = git branch --show-current
            #get git remote
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting remote git information"
            $rm = _getRemote
            $rm | Out-String | Write-Verbose
            if ($null -eq $rm) {
                $rm = @()
            }
            $InputObject.RemoteRepository = $rm
        }

        $InputObject.UpdateUser = "$([system.environment]::UserDomainName)\$([System.Environment]::Username)"
        $InputObject.Computername = [System.Environment]::MachineName
        if ($PSCmdlet.ShouldProcess($InputObject.Name)) {
            $InputObject
            $InputObject.Save()
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end
}
