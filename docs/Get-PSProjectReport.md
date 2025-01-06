---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version: https://bit.ly/3OSBu3L
schema: 2.0.0
---

# Get-PSProjectReport

## SYNOPSIS

Manage all your PSProject folders.

## SYNTAX

### status (Default)

```yaml
Get-PSProjectReport [-Path] <String> [-Status <PSProjectStatus>]
[-Tag <String>] [<CommonParameters>]
```

### older

```yaml
Get-PSProjectReport [-Path] <String> [-Status <PSProjectStatus>]
[-OlderThan <Int32>] [-Tag <String>] [<CommonParameters>]
```

### newer

```yaml
Get-PSProjectReport [-Path] <String> [-Status <PSProjectStatus>]
[-NewerThan <Int32>] [-Tag <String>] [<CommonParameters>]
```

## DESCRIPTION

The PSProjectStatus module makes an assumption that the majority of your projects are organized under a parent folder like C:\Scripts. This command is designed to make it easier to identify and manage projects you are working on. The default behavior is to get PSProject information from the top-level folders in your root directory. But you can also filter on status, age, or tag.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSProjectReport c:\scripts -Status Other


   Name: PSMessaging [C:\Scripts\PSMessaging]

LastUpdate             Status            Tasks         GitBranch        Age
----------             ------            -----         ---------        ---
7/20/2022 11:58:54 AM  Other             {}                master  192.02:11
```

Get PSProject information based on a status.

### Example 2

```powershell
PS C:\> Get-PSProjectReport c:\scripts -NewerThan 10 -Status Stable


   Name: PluralsightTools [C:\Scripts\PluralsightTools]

LastUpdate             Status            Tasks             GitBranch        Age
----------             ------            -----             ---------        ---
1/20/2023 2:20:39 PM   Stable            {convert modu...       main   07.23:51
```

Get PSProjects modified within the last 10 days.

### Example 3

```powershell
PS C>\> Get-PSProjectReport c:\scripts -NewerThan 60 | Select-Object Path,Name,Status,Tags,LastUpdate | Out-GridView -Title "Select a project" -OutputMode Single | Foreach-Object { set-location $_.path ; code $_.path }
```

Get projects modified in the last 60 days and send to Out-GridView. The selected project folder will be opened in VSCode.

## PARAMETERS

### -NewerThan

Get projects where the age is newer than X number of days

```yaml
Type: Int32
Parameter Sets: newer
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OlderThan

Get projects where the age is older than X number of days

```yaml
Type: Int32
Parameter Sets: older
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specify the top level folder

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status

Filter projects by status

```yaml
Type: PSProjectStatus
Parameter Sets: (All)
Aliases:
Accepted values: Development, Updating, Stable, AlphaTesting, BetaTesting, ReleaseCandidate, Patching, UnitTesting, AcceptanceTesting, Other, Archive

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag

Get projects with a specific tag. You can combine this with other filtering parameters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSProject

## NOTES

## RELATED LINKS

[Get-PSProjectStatus](Get-PSProjectStatus.md)
