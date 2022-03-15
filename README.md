# PSProjectStatus

```powershell
Get-ChildItenm -Directory | foreach { Get-PSProjectStatus -path $_.fullname -WarningAction SilentlyContinue}
```