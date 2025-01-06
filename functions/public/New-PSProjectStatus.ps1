Function New-PSProjectStatus {
    [CmdletBinding(SupportsShouldProcess)]
    [alias('npstat')]
    [OutputType('PSProject')]
    Param (
        [Parameter(Position = 0, HelpMessage = 'What is the project name?')]
        [ValidateNotNullOrEmpty()]
        [String]$Name = (Split-Path (Get-Location).path -Leaf),

        [Parameter(HelpMessage = 'What is the project path?')]
        [ValidateScript({ Test-Path $_ })]
        [String]$Path = (Get-Location).path,

        [Parameter(HelpMessage = 'When was the project last worked on?')]
        [ValidateNotNullOrEmpty()]
        [alias('date')]
        [DateTime]$LastUpdate = (Get-Date),

        [Parameter(HelpMessage = 'What are the remaining tasks?')]
        [string[]]$Tasks,

        [Parameter(HelpMessage = 'What tags do you want to assign to this project?')]
        [string[]]$Tags,

        [Parameter(HelpMessage = 'When is the project status?')]
        [ValidateNotNullOrEmpty()]
        [PSProjectStatus]$Status = 'Development',

        [Parameter(HelpMessage = 'What is the project version?')]
        [ValidateNotNullOrEmpty()]
        [alias('version')]
        [version]$ProjectVersion,

        [Parameter(HelpMessage = 'Enter an optional comment. This could be git tag, or an indication about the type of project.')]
        [String]$Comment,

        [Parameter(HelpMessage = 'Overwrite an existing PSProjectStatus file.')]
        [switch]$Force
    )

    $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand

    _verbose -message $strings.Starting
    if ($MyInvocation.CommandOrigin -eq "Runspace") {
        #Hide this metadata when the command is called from another command
        _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
        _verbose -message ($strings.UsingHost -f $host.Name)
        _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
        _verbose -message ($strings.UsingModule -f $PSProjectStatusModule)
    }

    $exclude = 'Verbose', 'WhatIf', 'Confirm', 'ErrorAction', 'Debug',
    'WarningAction', 'WarningVariable', 'ErrorVariable', 'InformationAction',
    'InformationVariable', 'ProgressAction', 'Force'

    #convert the path to a filesystem path to avoid using PSDrive references
    $cPath = Convert-Path $Path

    _verbose ($strings.UsingPath -f $cPath)

    #Don't overwrite existing file unless -Force is specified
    $json = Join-Path -Path $cPath -ChildPath psproject.json

    if ((Test-Path -Path $json) -AND (-Not $Force)) {
        Write-Warning $strings.ExistingWarning
        #bail out of the command
        Return
    }

    _verbose $strings.NewInstance
    $new = [psproject]::New()
    $new.Path = $cPath
    $new | Select-Object * | Out-String | Write-Debug

    _verbose ($strings.UsingSchema -f $JsonSchema)

    #set the instance properties using parameter values from this command
    $PSBoundParameters.GetEnumerator() | Where-Object { $exclude -NotContains $_.key } |
    ForEach-Object {
        _verbose ($strings.SetProperty -f $_.key)
        $new.$($_.key) = $_.value
    }

    _verbose $strings.TestGit
    If (Test-Path .git) {
        $branch = git branch --show-current
        _verbose ($strings.FoundGit -f $branch)
        $new.GitBranch = $branch

        #get git remote
        $new.RemoteRepository = _getRemote
    }
    else {
        _verbose $Strings.NoGit
    }
    if ($PSCmdlet.ShouldProcess($Name)) {
        $new
        $new.Save()
    }

    _verbose $strings.Ending

}
