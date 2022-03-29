Function Get-PSProjectGitStatus {
    [CmdletBinding()]
    [alias('gitstat')]
    [OutputType('PSProjectGit')]
    Param( )

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
        Write-Verbose "You must run this command from the root of a git repository."
    }
}