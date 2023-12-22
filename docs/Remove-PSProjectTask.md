---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# Remove-PSProjectTask

## SYNOPSIS

Remove a task from the PSProject file.

## SYNTAX

```
Remove-PSProjectTask [-TaskID] <Int32[]> [-Path <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

You can manually remove tasks from the PSProject file, or you can use this function. Specify a task ID and it will be removed from the PSProject file.

## EXAMPLES

### Example 1

```powershell
PS C:\scripts\PSProjectStatus> Remove-PSProjectTask -TaskID 4,2
```

Remove tasks 4 and 2 from the PSProject file.

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

### -TaskID
Enter the task ID

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: ID

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### [Int]

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[New-PSProjectTask](New-PSProjectTask.md)

[Get-PSProjectTask](Get-PSProjectTask.md)