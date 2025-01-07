---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# Open-PSProjectStatusHelp

## SYNOPSIS

Ouvrir le document d'aide PSProjectStatus

## SYNTAX

```yaml
Open-PSProjectStatusHelp [-AsMarkdown] [<CommonParameters>]
```

## DESCRIPTION

Utilisez cette commande pour ouvrir le document d'aide PDF pour le module PSProjectStatus avec l'application associée pour les fichiers PDF. Si vous exécutez PowerShell 7, vous pouvez également afficher la documentation sous forme de document markdown avec le paramètre -AsMarkdown. Il s'agit d'un paramètre dynamique qui n'existe pas dans Windows PowerShell.

## EXAMPLES

### Example 1

```powershell
PS C:\> Open-PSProjectStatusHelp
```

Le fichier doit s'ouvrir dans l'application par défaut pour les fichiers PDF.

### Example 2

```powershell
PS C:\> Open-PSProjectStatusHelp -AsMarkdown | more
```

Affichez le fichier d'aide sous forme de document markdown si vous exécutez PowerShell 7.

## PARAMETERS

### -AsMarkdown

Si vous exécutez PowerShell 7, vous pouvez également afficher la documentation sous forme de document markdown avec le paramètre -AsMarkdown. Il s'agit d'un paramètre dynamique qui n'existe pas dans Windows PowerShell.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: md

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, et -WarningVariable. Pour plus d'informations, consultez [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[PSProjectStatus GitHub Repository:](https://github.com/jdhitsolutions/PSProjectStatus)
