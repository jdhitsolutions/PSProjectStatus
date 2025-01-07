---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# Get-PSProjectStatus

## SYNOPSIS

Obtenir le statut du projet.

## SYNTAX

```yaml
Get-PSProjectStatus [[-Path] <String>] [<CommonParameters>]
```

## DESCRIPTION

Cette commande obtiendra le statut du projet à partir du fichier JSON trouvé dans le répertoire racine du module. Get-PSProjectStatus vérifiera le répertoire actuel par défaut, ou vous pouvez spécifier le chemin parent d'un autre répertoire.

## EXAMPLES

### Example 1

```powershell
PS C:\Scripts\PSClock> Get-PSProjectStatus

   Name: PSClock [C:\Scripts\PSClock]

LastUpdate             Status            Tasks             GitBranch      Age
----------             ------            -----             ---------      ---
10/17/2024 1:00:56 PM  Stable            {Pester tests}         main 80.20:40
```

Obtenez le statut du répertoire actuel.

### Example 2

```powershell
C:\Scripts\ dir -Directory | Get-PSProjectStatus -WarningAction SilentlyContinue

  Name: ADReportingTools [C:\Scripts\ADReportingTools]

LastUpdate             Status            Tasks             GitBranch        Age
----------             ------            -----             ---------        ---
6/21/2021 4:47:11 PM   Updating          {Publish new re       1.4.0  266.17:59

   Name: GitDevTest [C:\scripts\GitDevTest]

LastUpdate             Status            Tasks             GitBranch        Age
----------             ------            -----             ---------        ---
2/3/2022 4:50:37 PM    Stable            {update readme,       master   39.17:55

   Name: MyTasks [C:\Scripts\MyTasks]

LastUpdate             Status            Tasks             GitBranch        Age
----------             ------            -----             ---------        ---
10/14/2020 1:29:59 PM  Stable                                 master  516.21:16
...
```

Obtenez le statut de plusieurs projets. Vous pouvez également utiliser la commande Get-PSProjectReport.

### Example 3

```powershell
PS C:\Scripts\PSCalendar> Get-PSProjectStatus | Format-List

   Project: PSCalendar [C:\scripts\PSCalendar]

Version    : 2.9.0
Status     : Stable
Tasks      : {Update Help, Issue 34}
Tags       : {}
GitBranch  : master
LastUpdate : 3/1/2022 5:50:00 AM
Age        : 669.10:07:19
```

Utilisez la vue Liste par défaut. Cela facilite la visualisation des tâches.

### Example 4

```powershell
PS C:\Scripts\PSProjectStatus> Get-PSProjectStatus | Select-Object VersionInfo,Âge

Name       : PSProjectStatus
Status     : Updating
Version    : 0.5.0
GitBranch  : 0.5.0
LastUpdate : 3/23/2022 11:30:42 AM
Age        : 00:06:06.2337458
```

Obtenez le statut en utilisant la propriété versionInfo et la propriété de script Âge.

## PARAMETERS

### -Path

Entrez le chemin parent vers le fichier psproject.json, par Example
c:\scripts\mymodule

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

### CommonParameters

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Aucune

## OUTPUTS

### PSProject

## NOTES

Cette commande a un alias de gpstat.

En savoir plus sur PowerShell : http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Set-PSProjectStatus](Set-PSProjectStatus.md)

[New-PSProjectStatus](New-PSProjectStatus.md)

[Get-PSProjectReport](Get-PSProjectReport.md)
