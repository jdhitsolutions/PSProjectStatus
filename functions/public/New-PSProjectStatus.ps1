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
        [String]$Comment,

        [Parameter(HelpMessage = "Overwrite an existing PSProjectStatus file.")]
        [switch]$Force
    )

    Write-Verbose "[$((Get-Date).TimeOfDay)] Starting $($MyInvocation.MyCommand)"
    Write-Verbose "[$((Get-Date).TimeOfDay)] Running under PowerShell version $($PSVersionTable.PSVersion)"
    Write-Verbose "[$((Get-Date).TimeOfDay)] Using PowerShell Host $($Host.Name)"

    $exclude = "Verbose", "WhatIf", "Confirm", "ErrorAction", "Debug",
    "WarningAction", "WarningVariable", "ErrorVariable","InformationAction",
    "InformationVariable","ProgressAction","Force"

    #convert the path to a filesystem path to avoid using PSDrive references
    $cPath = Convert-Path $Path
    Write-Verbose "[$((Get-Date).TimeOfDay)] Using path $Path"

    #Don't overwrite existing file unless -Force is specified
    $json = Join-Path -Path $cPath -ChildPath psproject.json

    if ((Test-Path -path $json) -AND (-Not $Force)) {
        Write-Warning "An existing project status file was found. You must either delete the file or re-run this command with -Force."
        #bail out of the command
        Return
    }

    Write-Verbose "[$((Get-Date).TimeOfDay)] Creating a new instance of the PSProject class"
    $new = [psproject]::New()
    $new.Path = $cPath
    $new | Select-Object * | Out-String | Write-Debug
    Write-Verbose "[$((Get-Date).TimeOfDay)] Using schema path $jsonSchema"

    #set the instance properties using parameter values from this command
    $PSBoundParameters.GetEnumerator() | Where-Object { $exclude -NotContains $_.key } |
    ForEach-Object {
        Write-Verbose "[$((Get-Date).TimeOfDay)] Setting property $($_.key)"
        $new.$($_.key) = $_.value
    }

    Write-Verbose "Testing for .git"
    If (Test-Path .git) {
        $branch = git branch --show-current
        Write-Verbose "[$((Get-Date).TimeOfDay)] Detected git branch $branch"
        $new.GitBranch = $branch

        #get git remote
        $new.RemoteRepository = _getRemote
    }
    else {
        Write-Verbose "[$((Get-Date).TimeOfDay)] No git branch detected"
    }
    if ($PSCmdlet.ShouldProcess($Name)) {
        $new
        $new.Save()
    }
    Write-Verbose "[$((Get-Date).TimeOfDay)] Ending $($MyInvocation.MyCommand)"

}
