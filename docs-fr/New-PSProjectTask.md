---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# New-PSProjectTask

## SYNOPSIS

Créer une nouvelle tâche dans le fichier PSProject.

## SYNTAX

```yaml
New-PSProjectTask [-TaskDescription] <String[]> [-Path <String>] [-PassThru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Vous pouvez ajouter des tâches directement dans le fichier PSProject, ou vous pouvez utiliser cette fonction. Spécifiez une description de tâche et elle sera ajoutée au fichier PSProject. L'ID de la tâche est attribué automatiquement.

Vous pouvez également utiliser Set-PSProjectTask pour définir des tâches.

## EXAMPLES

### Example 1

```powershell
PS C:\Scripts\PSProjectStatus> New-PSProjectTask -TaskDescription "Mettre à jour le README"
```

Ajouter une nouvelle tâche.

### Example 2

```powershell
C:\Scripts\PSProjectStatus> New-PSProjectTask -TaskDescription "Tests Pester" -PassThru

   Name: PSProjectStatus [C:\Scripts\PSProjectStatus]

   Tests Pester [7]
```

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

### -PassThru

Afficher la nouvelle tâche.

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

### -TaskDescription

Entrez la description de la tâche.

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

### System.String

## OUTPUTS

### None

### psProjectTask

## NOTES

## RELATED LINKS

[Get-PSProjectTask](Get-PSProjectTask.md)

[Remove-PSProjectTask](Remove-PSProjectTask.md)
