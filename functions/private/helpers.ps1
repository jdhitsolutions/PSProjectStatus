#these are the module's private helper functions

function _getRemote {
    [cmdletbinding()]
    Param()

    if (Test-Path .git) {
        $remotes = git remote -v
        if ($remotes) {
            foreach ($remote in $remotes) {
                $split = $remote.split()
                $Name = $split[0]
                $Url = $split[1]
                $Mode = $split[2].replace("(", "").Replace(")", "")
                [PSProjectRemote]::new($name, $url, $mode)
            } #foreach
        } #if remotes found
        else {
            Write-Verbose "No remote git information detected."
        }
    } #if .git found
    else {
        Write-Warning "Could not find .git in the current location."
    }
}

function _getLastCommitDate {
    [CmdletBinding()]
    Param()
    if (Test-Path .git) {
        $dt = git log --max-count 1 --date=iso | Select-String Date
        if ($dt) {
            $split = $dt -split ":", 2
            #Get the date
            $split[1].Trim() -as [datetime]
        }
    }
}

function _getLastPushDate {
    [CmdletBinding()]
    Param([string]$Remote)
    if (Test-Path .git) {

        $dt = git log --remotes=$remote --max-count 1 --date=iso | Select-String Date
        if ($dt) {
            $split = $dt -split ":", 2
            #Get the date
            $split[1].Trim() -as [datetime]
        }
    }
}


#for possible future use
Function _getStatusEnum {
    [cmdletbinding()]
    Param()
    [enum]::GetValues([PSProjectStatus]).foreach({ $_.tostring() })
}

