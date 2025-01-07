---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# Set-PSProjectStatus

## SYNOPSIS

Mettre à jour le statut d'un PSProject.

## SYNTAX

```yaml
Set-PSProjectStatus [[-InputObject] <Object>] [[-Name] <String>]
[[-LastUpdate] <DateTime>] [[-Tasks] <String[]>] [-Concatenate]
[-Tags <String[]>] [[-Status] <PSProjectStatus>]
[-ProjectVersion <Version>] [-Comment <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Utilisez cette commande pour mettre à jour le statut d'un PSProject. Si une branche git est détectée, elle sera automatiquement utilisée. Idéalement, vous exécuterez Set-PSProjectStatus depuis le répertoire racine du module. Vous pouvez toujours modifier manuellement le fichier psproject.json dans votre éditeur. Pour mettre à jour manuellement la valeur LastUpdate, convertissez une valeur datetime en JSON.

Get-Date -format o | Set-Clipboard

Copiez manuellement la valeur dans le fichier JSON.

La valeur Status est un entier indiquant une valeur d'énumération privée.

- Development = 0
- Updating = 1
- Stable = 2
- AlphaTesting = 3
- BetaTesting = 4
- ReleaseCandidate = 5
- Patching = 6
- UnitTesting = 7
- AcceptanceTesting = 8
- Other = 9

Entrez l'une de ces valeurs de chaîne. Si vous modifiez le fichier dans VSCode, il devrait détecter le schéma JSON et fournir des valeurs de complétion.

## EXAMPLES

### Example 1

```powershell
PS C:\Scripts\PSProjectStatus> Set-PSProjectStatus -Status Development -comment (git tag -l | Select-Object -last 1)

   Name: PSProjectStatus [C:\scripts\PSProjectStatus]

LastUpdate             Status      Tasks              GitBranch          Age
----------             ------      -----              ---------          ---
15/03/2023 10:09:05    Develo..    {help docs, readm… 0.2.0         00.00:00
```

Mettez à jour le statut du projet en utilisant la date et l'heure actuelles. Définissez la propriété Status sur Development et utilisez le dernier tag git comme commentaire.

### Example 2

```powershell
PS C:\Scripts\PSProjectStatus> Set-PSProjectStatus -Status Development -Tasks "github" -Concatenate | Format-List

   Project: PSProjectStatus [C:\scripts\PSProjectStatus]

Version    : 0.5.0
Status     : Updating
Tasks      : {help docs, readme, pester tests, resolve project path for json…}
GitBranch  : 0.5.0
LastUpdate : 23/03/2023 10:20:26
```

Mettez à jour le projet et ajoutez une tâche.

## PARAMETERS

### -Concatenate

Concaténer de nouvelles tâches.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: add

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -InputObject

Spécifiez un objet PSProject.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: PSProject file in the current directory
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LastUpdate

Quand le projet a-t-il été travaillé ou mis à jour pour la dernière fois ?

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: date

Required: False
Position: 2
Default value: current date and time
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Quel est le nom du projet ?

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status

Quel est le statut du projet ? Les valeurs acceptées sont Development, Updating, Stable, AlphaTesting, BetaTesting, ReleaseCandidate, Patching, UnitTesting, AcceptanceTesting, et Other.

```yaml
Type: PSProjectStatus
Parameter Sets: (All)
Aliases:
Accepted values: Development, Updating, Stable, AlphaTesting, BetaTesting, ReleaseCandidate, Patching, UnitTesting, AcceptanceTesting, Other

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tasks

Quelles sont les tâches restantes ?

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
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

### -ProjectVersion

Quelle est la version du projet ?

```yaml
Type: Version
Parameter Sets: (All)
Aliases: version

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Comment

Entrez un commentaire facultatif. Cela pourrait être un tag git, ou une indication sur le type de projet.

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

### -Tags

Quels tags voulez-vous attribuer à ce projet ? Si vous souhaitez ajouter des tags, vous devez soit redéfinir tous les tags, soit ajouter un tag manuellement au fichier psproject.json.

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

### CommonParameters

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, et -WarningVariable. Pour plus d'informations, consultez [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### PSProject

## OUTPUTS

### PSProject

## NOTES

Cette commande a un alias de spstat.

En savoir plus sur PowerShell : http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[New-PSProjectStatus](New-PSProjectStatus.md)

[Get-PSProjectStatus](Get-PSProjectStatus.md)

[New-PSProjectTask](New-PSProjectTask.md)
