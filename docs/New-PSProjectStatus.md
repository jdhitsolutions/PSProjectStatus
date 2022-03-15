---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# New-PSProjectStatus

## SYNOPSIS

Create a new PSProjectStatus.

## SYNTAX

```yaml
New-PSProjectStatus [[-Name] <String>] [-Path <String>] [-LastUpdate <DateTime>] [-Tasks <String[]>] [-Status <PSProjectStatus>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Create a new PSProject file. Ideally, you will run this command in the module root directory.

## EXAMPLES

### Example 1

```powershell
PS S:\PSScriptingInventory> New-PSProjectStatus -LastUpdate (Get-item .\PSScriptingInventory.psd1).lastwritetime -Status Stable

   Name: PSScriptingInventory [C:\scripts\PSScriptingInventory]

LastUpdate             Status      Tasks              GitBranch          Age
----------             ------      -----              ---------          ---
6/19/2020 8:42:04 AM   Stable                         master       634.01:13
```

Create a new project status. PSDrive references will be converted to filesystem paths. The Age property is automatically calculated from the LastUpdate value.

## PARAMETERS

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

### -LastUpdate

When was the project last worked on?

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: date

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

What is the project name? The default is the current folder name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: current folder name
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

What is the project path?

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: .
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
Position: Named
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
Position: Named
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

### None

## OUTPUTS

### PSProject

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSProjectStatus](Get-PSProjectStatus.md)

[Set-PSProjectStatus](Set-PSProjectStatus.md)
