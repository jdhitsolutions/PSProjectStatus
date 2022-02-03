Function New-PSProjectStatus {
    [cmdletbinding(SupportsShouldProcess)]
    Param (
        [Parameter(Position = 0, HelpMessage = "What is the project name?")]
        [ValidateNotNullOrEmpty()]
        [string]$Name = (Split-Path (Get-Location).path -Leaf),

        [Parameter(HelpMessage = "What is the project path?")]
        [ValidateScript({ Test-Path $_ })]
        [string]$Path = (Get-Location).path,

        [Parameter(HelpMessage = "When was the project last worked on?")]
        [ValidateNotNullOrEmpty()]
        [alias("date")]
        [datetime]$LastUpdate = (Get-Date),

        [Parameter(HelpMessage = "What are the remaining tasks?")]
        [string[]]$Tasks,

        [Parameter(HelpMessage = "When was the project status?")]
        [ValidateNotNullOrEmpty()]
        [PSProjectStatus]$Status = "Development"
    )

    $exclude = "Verbose", "WhatIf", "Confirm", "ErrorAction", "Debug",
    "WarningAction", "WarningVariable", "ErrorVariable"
    $new = [psproject]::New()
    $PSBoundParameters.GetEnumerator() | Where-Object { $exclude -notcontains $_.key } |
    ForEach-Object {
        $new.$($_.key) = $_.value
    }

    If (Test-Path .git) {
        $new.GitBranch = git branch --show-current
    }
    if ($pscmdlet.ShouldProcess($Name)) {
        $new
        $new.Save()
    }
}
