---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# Set-PSProjectStatus

## SYNOPSIS

Update a PSProject status.

## SYNTAX

```yaml
Set-PSProjectStatus [[-InputObject] <Object>] [[-Name] <String>] [[-LastUpdate] <DateTime>] [[-Tasks] <String[]>] [-Concatenate] [[-Status] <PSProjectStatus>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Use this command to update a PSProject status. Ideally, you wil run the Set-PSProjectStatus from the module root directory. You can always manually modify the psproject.json file in your editor. To manually update the LastUpdate value, convert a datetime value to JSON.

Get-Date | ConvertTo-JSON | Set-Clipboard

The Status value is an integer indicating a private enumaration value.

Development = 0
Updating = 1
Stable = 2
AlphaTesting = 3
BetaTesting = 4
ReleaseCandidate = 5
Patching = 6
UnitTesting = 7
AcceptanceTesting = 8
Other = 9

## EXAMPLES

### Example 1

```powershell
PS C:\Scripts\PSProjectStatus> Set-PSProjectStatus -LastUpdate (get-date) -Status Development

   Name: PSProjectStatus [C:\scripts\PSProjectStatus]

LastUpdate             Status      Tasks              GitBranch          Age
----------             ------      -----              ---------          ---
3/15/2022 10:09:05 AM  Develo..    {help docs, readm… 0.2.0         00.00:00
```

### Example 2

```powershell
PS C:\Scripts\PSProjectStatus> Set-PSProjectStatus -LastUpdate (Get-Date) -Status Development -Tasks "github" -Concatenate | Format-List

Name       : PSProjectStatus
Path       : C:\scripts\PSProjectStatus
LastUpdate : 3/15/2022 10:20:26 AM
Status     : Development
Tasks      : {help docs, readme, pester tests, resolve project path for json…}
GitBranch  : 0.2.0
Age        : 00:00:00.0610744
```

Update the project and add a task.

## PARAMETERS

### -Concatenate

Concatentate new tasks.

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

When was the project last worked on?

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: date

Required: False
Position: 2
Default value: None
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### PSProject

## OUTPUTS

### PSProject

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[New-PSProjectStatus](New-PSProjectStatus.md)

[Get-PSProjectStatus](Get-PSProjectStatus.md)
