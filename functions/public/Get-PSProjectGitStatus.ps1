Function Get-PSProjectGitStatus {
    [CmdletBinding()]
    [alias('gitstat')]
    [OutputType('PSProjectGit')]
    Param( )

    $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
    $PSDefaultParameterValues["_verbose:block"] = "Process"

    _verbose -message $strings.Starting
    if ($MyInvocation.CommandOrigin -eq "Runspace") {
        #Hide this metadata when the command is called from another command
        _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
        _verbose -message ($strings.UsingHost -f $host.Name)
        _verbose -message ($strings.UsingModule -f $PSProjectStatusModule)
    }

    if (Test-Path .git) {
        $remotes = _getRemote | Where-Object { $_.mode -eq 'push' } |
        Select-Object -Property @{Name = "RemoteName"; Expression = { $_.Name } },
        @{Name = "LastPush"; Expression= { _getLastPushDate -remote $_name }}

        [PSCustomObject]@{
            PSTypename = "PSProjectGit"
            Name       = (Get-PSProjectStatus).Name
            Branch     = git branch --show-current
            LastCommit = _getLastCommitDate
            Remote     = $remotes
        }
    }
    else {
        Write-Verbose $strings.gitWarning
    }
    $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
    _verbose $strings.Ending
}
