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
}

Class PSProject {
    [string]$Name = (Split-Path (Get-Location).path -Leaf)
    [string]$Path = (Convert-Path (Get-Location).path)
    [datetime]$LastUpdate = (Get-Date)
    [string[]]$Tasks
    [PSProjectStatus]$Status = "Development"
    [Version]$ProjectVersion = (Test-ModuleManifest ".\$(split-path $pwd -leaf).psd1" -ErrorAction SilentlyContinue).version
    [string]$GitBranch
    #using .NET classes to ensure compatibility with non-Windows platforms
    [string]$UpdateUser = "$([system.environment]::UserDomainName)\$([System.Environment]::Username)"
    [string]$Computername = [System.Environment]::MachineName
    [PSProjectRemote[]]$RemoteRepository = $(_getRemote)

    [void]Save() {
        $json = Join-Path -Path $this.path -ChildPath psproject.json
        #convert the ProjectVersion to a string in the JSON file
        $this | Select-Object Name,Path,LastUpdate,Status,
        @{Name="ProjectVersion";Expression={$_.ProjectVersion.toString()}},UpdateUser,
        Computername,RemoteRepository,Tasks,GitBranch | ConvertTo-Json | Out-File $json
    }
    [void]RefreshProjectVersion() {
        $this.ProjectVersion = (Test-ModuleManifest ".\$(split-path $pwd -leaf).psd1" -ErrorAction SilentlyContinue).version
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
                    $Mode = $split[2].replace("(","").Replace(")","")
                    $repos += [PSProjectRemote]::new($remotename,$url,$mode)
                } #foreach
                $this.RemoteRepository = $repos
            } #if remotes found
        }
    }
}

Get-ChildItem $psscriptroot\functions\*.ps1 -Recurse |
ForEach-Object {
    . $_.FullName
}

