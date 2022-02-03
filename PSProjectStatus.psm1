enum PSProjectStatus {
    Development
    Updating
    Stable
}

Class PSProject {
    [string]$Name = (Split-Path (Get-Location).path -Leaf)
    [string]$Path = (Get-Location).path
    [datetime]$LastUpdate = (Get-Date)
    [string[]]$Tasks
    [PSProjectStatus]$Status = "Development"
    [string]$GitBranch

    [void]Save() {
        $json = Join-Path -Path $this.path -ChildPath psproject.json
        $this | Select-Object -Property * -exclude Age | ConvertTo-Json | Out-File $json
    }
}

Get-ChildItem $psscriptroot\functions\*.ps1 -Recurse |
ForEach-Object {
    . $_.FullName
}

Update-TypeData -TypeName PSProject -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.lastUpdate } -Force