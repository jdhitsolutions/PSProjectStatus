#these are the module's private helper functions

function _getRemote {
    [CmdletBinding()]
    Param()

    if (Test-Path .git) {
        $remotes = git remote -v
        if ($remotes) {
            foreach ($remote in $remotes) {
                $split = $remote.split()
                $Name = $split[0]
                $Url = $split[1]
                $Mode = $split[2].replace('(', '').Replace(')', '')
                [PSProjectRemote]::new($name, $url, $mode)
            } #foreach
        } #if remotes found
        else {
            Write-Debug $strings.NoGitRemote
        }
    } #if .git found
    else {
        Write-Warning $strings.NoGitFolder
    }
}

function _getLastCommitDate {
    [CmdletBinding()]
    Param()
    if (Test-Path .git) {
        $dt = git log --max-count 1 --date=iso | Select-String Date
        if ($dt) {
            $split = $dt -split ':', 2
            #Get the date
            $split[1].Trim() -as [DateTime]
        }
    }
}

function _getLastPushDate {
    [CmdletBinding()]
    Param([String]$Remote)
    if (Test-Path .git) {
        $dt = git log --remotes=$remote --max-count 1 --date=iso | Select-String Date
        if ($dt) {
            $split = $dt -split ':', 2
            #Get the date
            $split[1].Trim() -as [DateTime]
        }
    }
}


function _verbose {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [string]$Message,
        [string]$Block = 'PROCESS',
        [string]$Command
    )

    #Display each command name in a different color sequence
    if ($global:PSProjectAnsi.ContainsKey($Command)) {
        [string]$ANSI =  $global:PSProjectAnsi[$Command]
    }
    else {
        [string]$ANSI =  $global:PSProjectAnsi['DEFAULT']
    }

    $BlockString = $Block.ToUpper().PadRight(7, ' ')
    $Reset = "$([char]27)[0m"
    $ToD = (Get-Date).TimeOfDay
    $AnsiCommand = "$([char]27)$Ansi$($command)"
    $Italic = "$([char]27)[3m"
    #Write-Verbose "[$((Get-Date).TimeOfDay) $BlockString] $([char]27)$Ansi$($command)$([char]27)[0m: $([char]27)[3m$message$([char]27)[0m"
    if ($Host.Name -eq 'Windows PowerShell ISE Host') {
        $msg = '[{0} {1}] {2}-> {3}' -f $Tod, $BlockString, $Command, $Message
    }
    else {
        $msg = '[{0} {1}] {2}{3}-> {4} {5}{3}' -f $Tod, $BlockString, $AnsiCommand, $Reset, $Italic, $Message
    }
    Write-Verbose -Message $msg

}

######################################################

#for possible future use
Function _getStatusEnum {
    [CmdletBinding()]
    Param()
    [enum]::GetValues([PSProjectStatus]).foreach({ $_.ToString() })
}