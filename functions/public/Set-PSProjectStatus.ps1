Function Set-PSProjectStatus {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType("PSProject")]
    Param(
        [Parameter(ValueFromPipeline, HelpMessage = "Specify a PSProject object")]
        [ValidateNotNullOrEmpty()]
        [object]$InputObject = (Get-PSProjectStatus -Path .),

        [Parameter(HelpMessage = "What is the project name?")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(HelpMessage = "When was the project last worked on?")]
        [ValidateNotNullOrEmpty()]
        [alias("date")]
        [datetime]$LastUpdate,

        [Parameter(HelpMessage = "What are the remaining tasks?")]
        [string[]]$Tasks,

        [Parameter(HelpMessage = "Concatentate tasks")]
        [switch]$Concatenate,

        [Parameter(HelpMessage = "What is the project status?")]
        [ValidateNotNullOrEmpty()]
        [PSProjectStatus]$Status
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Updating $($inputobject.name)"

        $properties = "Name","Status","LastUpdate"
        foreach ($property in $properties) {
            if ($PSBoundParameters.ContainsKey($property)) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Updating $property"
                $inputobject.$property = $PSBoundParameters[$property]
            }
        }
        if ($PSBoundParameters.ContainsKey("Tasks")) {
            if ($Concatenate) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Appending tasks"
                $inputobject.Tasks += $PSBoundParameters["Tasks"]
            }
            else {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Replacing tasks"
                $inputobject.Tasks = $PSBoundParameters["Tasks"]
            }
        }
        If (Test-Path .git) {
            $inputobject.GitBranch = git branch --show-current
        }
        if ($PSCmdlet.ShouldProcess($InputObject.Name)) {
            $InputObject
            $InputObject.Save()
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end
}
