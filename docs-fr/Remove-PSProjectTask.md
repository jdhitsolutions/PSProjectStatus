---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# Remove-PSProjectTask

## SYNOPSIS

Supprimer une tâche du fichier PSProject.

## SYNTAX

```yaml
Remove-PSProjectTask [-TaskID] <Int32[]> [-Path <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Vous pouvez supprimer manuellement des tâches du fichier PSProject, ou vous pouvez utiliser cette fonction. Spécifiez un ID de tâche et il sera supprimé du fichier PSProject.

## EXAMPLES

### Example 1

```powershell
PS C:\scripts\PSProjectStatus> Remove-PSProjectTask -TaskID 4,2
```

Supprimez les tâches 4 et 2 du fichier PSProject.

## PARAMETERS

### -Confirm

Vous demande de confirmer avant d'exécuter le cmdlet.

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

Entrez le chemin parent vers le fichier psproject.json, par Example c:\scripts\mymodule.

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

Entrez l'ID de la tâche

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

Montre ce qui se passerait si le cmdlet s'exécutait.
Le cmdlet n'est pas exécuté.

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

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, et -WarningVariable. Pour plus d'informations, consultez [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [Int]

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[New-PSProjectTask](New-PSProjectTask.md)

[Get-PSProjectTask](Get-PSProjectTask.md)
