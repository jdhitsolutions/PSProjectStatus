---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# Get-PSProjectGitStatus

## SYNOPSIS

Obtenir le statut du projet git.

## SYNTAX

```yaml
Get-PSProjectGitStatus [<CommonParameters>]
```

## DESCRIPTION

Il est présumé que vous utilisez git pour gérer votre projet. Si c'est le cas, certaines informations liées à git sont incluses dans la sortie de PSProjectStatus. Get-PSProjectGitStatus est destiné à fournir plus de détails spécifiques à git. Vous devez exécuter cette commande à la racine de votre répertoire de projet. Si le projet n'est pas initialisé avec git, rien ne sera retourné.

## EXAMPLES

### Example 1

```powershell
PS C:\Scripts\PSProjectStatus> Get-PSProjectGitStatus

Name            Branch LastCommit           Remote
----            ------ ----------           ------
PSProjectStatus 0.6.0  3/29/2022 5:23:20 PM @{RemoteName=origin; LastPush=3/26/2022 10:36:00 AM}```

## PARAMETERS

### CommonParameters

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Aucune

## OUTPUTS

### PSProjectGit

## NOTES

Cette commande a un alias de gitstat.

En savoir plus sur PowerShell : http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSProjectStatus](Get-PSProjectStatus.md)
