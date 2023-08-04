Function New-PSProjectStatus {
    [CmdletBinding(SupportsShouldProcess)]
    [alias("npstat")]
    [OutputType("PSProject")]
    Param (
        [Parameter(Position = 0, HelpMessage = "What is the project name?")]
        [ValidateNotNullOrEmpty()]
        [String]$Name = (Split-Path (Get-Location).path -Leaf),

        [Parameter(HelpMessage = "What is the project path?")]
        [ValidateScript({ Test-Path $_ })]
        [String]$Path = (Get-Location).path,

        [Parameter(HelpMessage = "When was the project last worked on?")]
        [ValidateNotNullOrEmpty()]
        [alias("date")]
        [DateTime]$LastUpdate = (Get-Date),

        [Parameter(HelpMessage = "What are the remaining tasks?")]
        [string[]]$Tasks,

        [Parameter(HelpMessage = "When is the project status?")]
        [ValidateNotNullOrEmpty()]
        [PSProjectStatus]$Status = "Development",

        [Parameter(HelpMessage = "What is the project version?")]
        [ValidateNotNullOrEmpty()]
        [alias("version")]
        [version]$ProjectVersion,

        [Parameter(HelpMessage = "Enter an optional comment. This could be git tag, or an indication about the type of project.")]
        [String]$Comment
    )

    Write-Verbose "Starting $($MyInvocation.MyCommand)"

    $exclude = "Verbose", "WhatIf", "Confirm", "ErrorAction", "Debug",
    "WarningAction", "WarningVariable", "ErrorVariable","InformationAction",
    "InformationVariable"

    Write-Verbose "Creating a new instance of the PSProject class"
    $new = [psproject]::New()
    $new | Select-Object * | Out-String | Write-Debug
    Write-Verbose "Using schema path $jsonSchema"
    #convert the path to a filesystem path to avoid using PSDrive references
    $new.Path = Convert-Path $Path
    Write-Verbose "Using path $Path"
    #set the instance properties using parameter values from this command
    $PSBoundParameters.GetEnumerator() | Where-Object { $exclude -NotContains $_.key } |
    ForEach-Object {
        Write-Verbose "Setting property $($_.key)"
        $new.$($_.key) = $_.value
    }

    Write-Verbose "Testing for .git"
    If (Test-Path .git) {
        $branch = git branch --show-current
        Write-Verbose "Detected git branch $branch"
        $new.GitBranch = $branch

        #get git remote
        $new.RemoteRepository = _getRemote
    }
    else {
        Write-Verbose "No git branch detected"
    }
    if ($PSCmdlet.ShouldProcess($Name)) {
        $new
        $new.Save()
    }
    Write-Verbose "Ending $($MyInvocation.MyCommand)"

}
