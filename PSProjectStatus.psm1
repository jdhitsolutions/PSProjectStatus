#dot source functions
Get-ChildItem $PSScriptRoot\functions\*.ps1 -Recurse |
ForEach-Object {
    . $_.FullName
}

#region class definitions
enum PSProjectStatus {
    Development
    Updating
    Stable
    AlphaTesting
    BetaTesting
    ReleaseCandidate
    Patching
    UnitTesting
    AcceptanceTesting
    Other
    Archive
}

Enum gitMode {
    fetch
    push
}

Class PSProjectRemote {
    [string]$Name
    [string]$Url
    [gitMode]$Mode

    PSProjectRemote ($Name, $url, $mode) {
        $this.Name = $Name
        $this.url = $url
        $this.mode = $mode
    }
    #allow an empty remote setting
    PSProjectRemote() {
        $this.Name = ''
        $this.url = ''
    }
}

Class PSProject {
    [string]$Name = (Split-Path (Get-Location).path -Leaf)
    [string]$Path = (Convert-Path (Get-Location).path)
    [DateTime]$LastUpdate = (Get-Date)
    [string[]]$Tasks = @()
    [PSProjectStatus]$Status = 'Development'
    [Version]$ProjectVersion = (Test-ModuleManifest ".\$(Split-Path $pwd -Leaf).psd1" -ErrorAction SilentlyContinue).version
    [string]$GitBranch = ''
    #using .NET classes to ensure compatibility with non-Windows platforms
    [string]$UpdateUser = "$([system.environment]::UserDomainName)\$([System.Environment]::Username)"
    [string]$Computername = [System.Environment]::MachineName
    [PSProjectRemote[]]$RemoteRepository = @()
    [string]$Comment = 'none'

    [void]Save() {
        $json = Join-Path -Path $this.path -ChildPath psproject.json
        #convert the ProjectVersion to a string in the JSON file
        #convert the LastUpdate to a formatted date string
        $this | Select-Object @{Name = '$schema'; Expression = { 'https://raw.githubusercontent.com/jdhitsolutions/PSProjectStatus/main/psproject.schema.json' } },
        Name, Path,
        @{Name = 'LastUpdate'; Expression = { '{0:o}' -f $_.LastUpdate } },
        @{Name = 'Status'; Expression = { $_.status.toString() } },
        @{Name = 'ProjectVersion'; Expression = { $_.ProjectVersion.toString() } },
        UpdateUser, Computername, RemoteRepository, Tasks, GitBranch, Comment |
        ConvertTo-Json | Out-File -FilePath $json -Encoding utf8
    }
    [void]RefreshProjectVersion() {
        $this.ProjectVersion = (Test-ModuleManifest ".\$(Split-Path $pwd -Leaf).psd1" -ErrorAction SilentlyContinue).version
    }
    [void]RefreshUser() {
        $this.UpdateUser = "$([system.environment]::UserDomainName)\$([System.Environment]::Username)"
    }
    [void]RefreshComputer() {
        $this.Computername = [System.Environment]::MachineName
    }
    [void]RefreshRemoteRepository() {
        if (Test-Path .git) {
            $remotes = git remote -v
            if ($remotes) {
                $repos = @()
                foreach ($remote in $remotes) {
                    $split = $remote.split()
                    $RemoteName = $split[0]
                    $Url = $split[1]
                    $Mode = $split[2].replace('(', '').Replace(')', '')
                    $repos += [PSProjectRemote]::new($remotename, $url, $mode)
                } #foreach
                $this.RemoteRepository = $repos
            } #if remotes found
        }
    }

    [void]RefreshAll() {
        $this.RefreshProjectVersion()
        $this.RefreshUser()
        $this.RefreshComputer()
        $this.RefreshRemoteRepository()
        $this.Save()
    }
}

#endregion

#region add a VSCode/PowerShell ISE extension to the project

if ($host.name -eq 'visual studio code host') {
    Function Update-PSProjectStatus {
        [cmdletbinding()]
        Param ($context)

        $title = "$([char]27)[4;3;38;5;228mStatus Options$([char]27)[0m"

        $menu = @"

        $title

        [1] Development        [6] ReleaseCandidate
        [2] Updating           [7] Patching
        [3] Stable             [8] UnitTesting
        [4] AlphaTesting       [9] AcceptanceTesting
        [5] BetaTesting        [10] Other
        [11] Archive
"@

        Do {
            Clear-Host
            Write-Host $menu
            [int]$r = Read-Host 'Select a project status. Enter no value to cancel'
            if ($r -eq 0) {
                #cancel
                return
            }
            if ($r -lt 1 -OR $r -gt 10) {
                $PSEditor.Window.ShowWarningMessage('You entered an invalid value. Enter nothing or a value between 1 and 10.')
            }

        } until ($r -ge 1 -AND $r -le 10)

        $PSEditor.Window.SetStatusBarMessage('Updating PSProject status', 3000)
        switch ($r) {
            1 { $status = 'Development' }
            2 { $status = 'Updating' }
            3 { $status = 'Stable' }
            4 { $status = 'AlphaTesting' }
            5 { $status = 'BetaTesting' }
            6 { $status = 'ReleaseCandidate' }
            7 { $status = 'Patching' }
            8 { $status = 'UnitTesting' }
            9 { $status = 'AcceptanceTesting' }
            10 { $status = 'Other' }
            11 {$status = 'Archive'}
        }

        if ($status) {
            #update the project if a status is specified
            $splat = @{
                LastUpdate = (Get-Date)
                Status     = $status
            }
            if (Test-Path ".\$(Split-Path $pwd -Leaf).psd1" ) {
                $splat.Add('ProjectVersion', (Test-ModuleManifest ".\$(Split-Path $pwd -Leaf).psd1").version)
            }

            $s = Set-PSProjectStatus @splat | Select-Object VersionInfo | Out-String
            #parse out ANSI escape sequences
            $detail = $s -replace "$([char]27)\[[\d;]*m", ''
            #show a summary message
            $PSEditor.Window.ShowInformationMessage($detail)
        }

    }#end function

    Register-EditorCommand -Function 'Update-PSProjectStatus' -name 'UpdatePSProjectStatus' -DisplayName 'Update PSProject Status'
} #VSCode

if ($host.name -match 'ISE') {
    #The ISE specific version of the update function
    Function Update-PSProjectStatus {
        [cmdletbinding()]
        Param ()

        $title = "Status Options`n    --------------"

        $menu = @"

    $title

    [1] Development        [6] ReleaseCandidate
    [2] Updating           [7] Patching
    [3] Stable             [8] UnitTesting
    [4] AlphaTesting       [9] AcceptanceTesting
    [5] BetaTesting        [10] Other
    [11] Archive

"@

        Write-Host $menu

        [int]$r = Read-Host 'Select a project status. Enter no value to cancel'
        if ($r -lt 1 -OR $r -gt 10) {
            return 'You entered an invalid value. '
        }
        switch ($r) {
            1 { $status = 'Development' }
            2 { $status = 'Updating' }
            3 { $status = 'Stable' }
            4 { $status = 'AlphaTesting' }
            5 { $status = 'BetaTesting' }
            6 { $status = 'ReleaseCandidate' }
            7 { $status = 'Patching' }
            8 { $status = 'UnitTesting' }
            9 { $status = 'AcceptanceTesting' }
            10 { $status = 'Other' }
            11 { $status = 'Archive'}
        }

        if ($status) {
            #update the project if a status is specified
            $splat = @{
                LastUpdate = (Get-Date)
                Status     = $status
            }
            if (Test-Path ".\$(Split-Path $pwd -Leaf).psd1" ) {
                $splat.Add('ProjectVersion', (Test-ModuleManifest ".\$(Split-Path $pwd -Leaf).psd1").version)
            }

            Set-PSProjectStatus @splat | Select-Object -Property VersionInfo
        }

    }#end function
    if ($psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.DisplayName -notContains 'Update PSProjectStatus') {
        #add the action to the Add-Ons menu
        [void]($psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add('Update PSProjectStatus', { Update-PSProjectStatus }, $Null))
    }
} #ISE

#endregion

#path to the JSON schema file
$jsonSchema = 'https://raw.githubusercontent.com/jdhitsolutions/PSProjectStatus/main/psproject.schema.json'

# for testing
# $jsonSchema = "file:///c:/scripts/psprojectstatus/psproject.schema.json"