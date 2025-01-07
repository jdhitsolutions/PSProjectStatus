---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# Get-PSProjectTask

## SYNOPSIS

Lister les tâches du projet

## SYNTAX

```yaml
Get-PSProjectTask [[-Path] <String>] [-TaskID <Int32>] [<CommonParameters>]
```

## DESCRIPTION

Lister les tâches définies dans le fichier PSProject. Vous recevrez un avertissement si aucune tâche n'est définie.

## EXAMPLES

### Example 1

```powershell
PS C:\PSWorkItem> Get-PSProjectTask

   Name: PSWorkItem [C:\Scripts\PSWorkItem]

   ● Pester tests [1]
   ● add message localization [2]
   ● fix PDF image location [3]

```

Afficher les tâches. Si vous exécutez cela dans la console de VSCode, vous devriez obtenir une sortie formatée en ANSI. Le numéro entre crochets est l'ID de la tâche.

### Example 2

```powershell
PS C:\PSWorkItem> Get-PSProjectTask -TaskID 2

   Name: PSWorkItem [C:\Scripts\PSWorkItem]

   ● add message localization [2]
```

Obtenir une tâche par numéro d'ID.

## PARAMETERS

### -Path

Entrez le chemin parent vers le fichier psproject.json, par Example
c:\scripts\mymodule.

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

### -TaskID

Obtenir une tâche par son numéro d'ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ID

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### psProjectTask

## NOTES

## RELATED LINKS

[New-PSProjectTask](New-PSProjectTask.md)

[Remove-PSProjectTask](Remove-PSProjectTask.md)
