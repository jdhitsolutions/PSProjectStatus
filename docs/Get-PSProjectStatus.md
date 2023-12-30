---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version: https://bit.ly/37oLez9
schema: 2.0.0
---

# Get-PSProjectStatus

## SYNOPSIS

Get project status.

## SYNTAX

```
Get-PSProjectStatus [[-Path] <String>] [<CommonParameters>]
```

## DESCRIPTION

This command will get the project status from the JSON file found in the module root directory. Get-PSProjectStatus will check the current directory by default, or you can specify the parent path of another directory.

## EXAMPLES

### Example 1

```powershell
PS C:\Scripts\PSClock> Get-PSProjectStatus

   Name: PSClock [C:\Scripts\PSClock]

LastUpdate             Status            Tasks            GitBranch          Age
----------             ------            -----            ---------          ---
3/2/2022 3:43:34 PM    Stable                                   main    12.19:14
```

Get the status from the current directory.

### Example 2

```powershell
C:\Scripts\ dir -Directory | Get-PSProjectStatus -WarningAction SilentlyContinue

   Name: ADReportingTools [C:\Scripts\ADReportingTools]

LastUpdate             Status            Tasks             GitBranch        Age
----------             ------            -----             ---------        ---
6/21/2021 4:47:11 PM   Updating          {Publish new re…      1.4.0  266.17:59

   Name: GitDevTest [C:\scripts\GitDevTest]

LastUpdate             Status            Tasks             GitBranch        Age
----------             ------            -----             ---------        ---
2/3/2022 4:50:37 PM    Stable            {update readme,…     master   39.17:55

   Name: MyTasks [C:\Scripts\MyTasks]

LastUpdate             Status            Tasks             GitBranch        Age
----------             ------            -----             ---------        ---
10/14/2020 1:29:59 PM  Stable                                 master  516.21:16
...
```

Get status for multiple projects. You could also use the Get-PSProjectReport command.

### Example 3

```powershell
PS C:\Scripts\PSCalendar> Get-PSProjectStatus | Format-List

   Project: PSCalendar [C:\scripts\PSCalendar]

Version    : 2.9.0
Status     : Stable
Tasks      : {Update Help, Issue 34}
Tags       : {}
GitBranch  : master
LastUpdate : 3/1/2022 5:50:00 AM
Age        : 669.10:07:19
```

Use the default List view. This makes it easier to view the tasks.

### Example 4

```powershell
PS C:\Scripts\PSProjectStatus> Get-PSProjectStatus | Select-Object VersionInfo,Age

Name       : PSProjectStatus
Status     : Updating
Version    : 0.5.0
GitBranch  : 0.5.0
LastUpdate : 3/23/2022 11:30:42 AM
Age        : 00:06:06.2337458
```

Get status using the versionInfo property set and the Age script property.

## PARAMETERS

### -Path

Enter the parent path to the psproject.json file, e.g.
c:\scripts\mymodule

```yaml
Type: String
Parameter Sets: (All)
Aliases: FullName

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSProject

## NOTES

This command has an alias of gpstat.

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Set-PSProjectStatus](Set-PSProjectStatus.md)

[New-PSProjectStatus](New-PSProjectStatus.md)

[Get-PSProjectReport](Get-PSProjectReport.md)
