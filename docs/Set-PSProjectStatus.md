---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version: https://bit.ly/3JlDkEM
schema: 2.0.0
---

# Set-PSProjectStatus

## SYNOPSIS

Update a PSProject status.

## SYNTAX

```
Set-PSProjectStatus [[-InputObject] <Object>] [[-Name] <String>]
[[-LastUpdate] <DateTime>] [[-Tasks] <String[]>] [-Concatenate]
[-Tags <String[]>] [[-Status] <PSProjectStatus>]
[-ProjectVersion <Version>] [-Comment <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to update a PSProject status. If a git branch is detected, it will automatically be used. Ideally, you will run Set-PSProjectStatus from the module root directory. You can always manually modify the psproject.json file in your editor. To manually update the LastUpdate value, convert a datetime value to JSON.

Get-Date -format o | Set-Clipboard

Manually copy the value into the JSON file.

The Status value is an integer indicating a private enumeration value.

- Development = 0
- Updating = 1
- Stable = 2
- AlphaTesting = 3
- BetaTesting = 4
- ReleaseCandidate = 5
- Patching = 6
- UnitTesting = 7
- AcceptanceTesting = 8
- Other = 9

Enter one of these string values. If you edit the file in VSCode, it should detect the JSON schema and provide completion values.

## EXAMPLES

### Example 1

```powershell
PS C:\Scripts\PSProjectStatus> Set-PSProjectStatus -Status Development -comment (git tag -l | Select-Object -last 1)

   Name: PSProjectStatus [C:\scripts\PSProjectStatus]

LastUpdate             Status      Tasks              GitBranch          Age
----------             ------      -----              ---------          ---
3/15/2023 10:09:05 AM  Develo..    {help docs, readm… 0.2.0         00.00:00
```

Update the project status using the current date and time. Set the Status property to Development and use the last git tag as a comment.

### Example 2

```powershell
PS C:\Scripts\PSProjectStatus> Set-PSProjectStatus -Status Development -Tasks "github" -Concatenate | Format-List

   Project: PSProjectStatus [C:\scripts\PSProjectStatus]

Version    : 0.5.0
Status     : Updating
Tasks      : {help docs, readme, pester tests, resolve project path for json…}
GitBranch  : 0.5.0
LastUpdate : 3/23/2023 10:20:26 AM
```

Update the project and add a task.

## PARAMETERS

### -Concatenate

Concatenate new tasks.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: add

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specify a PSProject object.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: PSProject file in the current directory
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LastUpdate

When was the project last worked on or updated?

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: date

Required: False
Position: 2
Default value: current date and time
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

What is the project name?

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status

What is the project status? Accepted values are Development, Updating, Stable, AlphaTesting, BetaTesting, ReleaseCandidate, Patching, UnitTesting, AcceptanceTesting, and Other.

```yaml
Type: PSProjectStatus
Parameter Sets: (All)
Aliases:
Accepted values: Development, Updating, Stable, AlphaTesting, BetaTesting, ReleaseCandidate, Patching, UnitTesting, AcceptanceTesting, Other

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tasks

What are the remaining tasks?

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProjectVersion

What is the project version?

```yaml
Type: Version
Parameter Sets: (All)
Aliases: version

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Comment

Enter an optional comment. This could be git tag, or an indication about the type of project.

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

### -Tags
What tags do you want to assign to this project? If you want to append tags you either have to re-define all tags, or add a tag manually to the psproject.json file.

```yaml
Type: String[]
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

### PSProject

## OUTPUTS

### PSProject

## NOTES

This command has an alias of spstat.

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[New-PSProjectStatus](New-PSProjectStatus.md)

[Get-PSProjectStatus](Get-PSProjectStatus.md)

[New-PSProjectTask](New-PSProjectTask.md)
