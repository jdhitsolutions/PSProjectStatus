---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# Get-PSProjectReport

## SYNOPSIS

Gérer tous vos dossiers PSProject.

## SYNTAX

### status (par défaut)

```yaml
Get-PSProjectReport [-Path] <String> [-Status <PSProjectStatus>]
[-Tag <String>] [<CommonParameters>]
```

### older

```yaml
Get-PSProjectReport [-Path] <String> [-Status <PSProjectStatus>]
[-OlderThan <Int32>] [-Tag <String>] [<CommonParameters>]
```

### newer

```yaml
Get-PSProjectReport [-Path] <String> [-Status <PSProjectStatus>]
[-NewerThan <Int32>] [-Tag <String>] [<CommonParameters>]
```

## DESCRIPTION

Le module PSProjectStatus suppose que la majorité de vos projets sont organisés sous un dossier parent comme C:\Scripts. Cette commande est conçue pour faciliter l'identification et la gestion des projets sur lesquels vous travaillez. Le comportement par défaut est d'obtenir des informations PSProject à partir des dossiers de niveau supérieur dans votre répertoire racine. Mais vous pouvez également filtrer par statut, âge ou tag.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSProjectReport c:\scripts -Status Other


   Name: PSMessaging [C:\Scripts\PSMessaging]

LastUpdate             Status            Tasks         GitBranch        Age
----------             ------            -----         ---------        ---
7/20/2022 11:58:54 AM  Other             {}                master  192.02:11
```

Obtenir des informations PSProject basées sur un statut.

### Example 2

```powershell
PS C:\> Get-PSProjectReport c:\scripts -NewerThan 10 -Status Stable


   Name: PluralsightTools [C:\Scripts\PluralsightTools]

LastUpdate             Status            Tasks             GitBranch        Age
----------             ------            -----             ---------        ---
1/20/2023 2:20:39 PM   Stable            {convert modu...       main   07.23:51
```

Obtenir des PSProjects modifiés au cours des 10 derniers jours.

### Example 3

```powershell
PS C>\> Get-PSProjectReport c:\scripts -NewerThan 60 |
Select-Object Path,Name,Status,Tags,LastUpdate |
Out-GridView -Title "Sélectionnez un projet" -OutputMode Single |
Foreach-Object { set-location $_.path ; code $_.path }
```

Obtenir des projets modifiés au cours des 60 derniers jours et envoyer à Out-GridView. Le dossier du projet sélectionné sera ouvert dans VSCode.

## PARAMETERS

### -NewerThan

Obtenir des projets dont l'âge est inférieur à X jours

```yaml
Type: Int32
Parameter Sets: newer
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OlderThan

Obtenir des projets dont l'âge est supérieur à X jours

```yaml
Type: Int32
Parameter Sets: older
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Spécifiez le dossier de niveau supérieur

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status

Filtrer les projets par statut

```yaml
Type: PSProjectStatus
Parameter Sets: (All)
Aliases:
Accepted values: Development, Updating, Stable, AlphaTesting, BetaTesting, ReleaseCandidate, Patching, UnitTesting, AcceptanceTesting, Other, Archive

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag

Obtenir des projets avec un tag spécifique. Vous pouvez combiner cela avec d'autres paramètres de filtrage.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Aucune

## OUTPUTS

### PSProject

## NOTES

## RELATED LINKS

[Get-PSProjectStatus](Get-PSProjectStatus.md)
