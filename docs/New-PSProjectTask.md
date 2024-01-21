---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version: https://bit.ly/3tyR5xe
schema: 2.0.0
---

# New-PSProjectTask

## SYNOPSIS

Create a new task in the PSProject file.

## SYNTAX

```
New-PSProjectTask [-TaskDescription] <String[]> [-Path <String>] [-PassThru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

You can add tasks directly in the PSProject file, or you can use this function. Specify a task description and it will be added to the PSProject file. The task ID is assigned automatically.

You can also use Set-PSProjectTask set tasks.

## EXAMPLES

### Example 1

```powershell
PS C:\Scripts\PSProjectStatus> New-PSProjectTask -TaskDescription "Update README"
```

Add a new task.

### Example 2

```powershell
C:\Scripts\PSProjectStatus> New-PSProjectTask -TaskDescription "Pester tests" -PassThru

   Name: PSProjectStatus [C:\Scripts\PSProjectStatus]

   Pester tests [7]
```

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

### -PassThru

Display the new task.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Enter the parent path to the psproject.json file, e.g.
c:\scripts\mymodule.

```yaml
Type: String
Parameter Sets: (All)
Aliases: FullName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TaskDescription
Enter the task description.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

### System.String

## OUTPUTS

### None

### psProjectTask

## NOTES

## RELATED LINKS

[Get-PSProjectTask](Get-PSProjectTask.md)

[Remove-PSProjectTask](Remove-PSProjectTask.md)
