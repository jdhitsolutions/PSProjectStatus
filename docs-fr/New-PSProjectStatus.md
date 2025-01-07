---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version:
schema: 2.0.0
---

# New-PSProjectStatus

## SYNOPSIS

Créer un nouveau PSProjectStatus.

## SYNTAX

```yaml
New-PSProjectStatus [[-Name] <String>] [-Path <String>] [-LastUpdate <DateTime>] [-Tasks <String[]>] [-Tags <String[]>] [-Status <PSProjectStatus>] [-ProjectVersion <Version>] [-Comment <String>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Créer un nouveau fichier PSProject. Idéalement, vous exécuterez cette commande dans le répertoire racine du module. Le manifeste du module, s'il est trouvé, sera utilisé pour la version du projet. Si une branche git est détectée, elle sera automatiquement utilisée.

La commande ne remplacera pas un fichier PSProjectStatus existant. Si vous souhaitez remplacer un fichier existant, utilisez le paramètre -Force.

## EXAMPLES

### Example 1

```powershell
PS C:\Projects\Contoso> New-PSProjectStatus

   Name: Contoso [C:\Projects\Contoso]

LastUpdate             Status         Tasks      GitBranch        Age
----------             ------         -----      ---------        ---
12/22/2024 8:35:55 AM  Development    {}              main   00.00:00
```

Créer un nouveau statut de projet en utilisant les valeurs par défaut.

### Example 2

```powershell
PS C:\Scripts\PSScriptingInventory> New-PSProjectStatus -LastUpdate (Get-Item .\PSScriptingInventory.psd1).LastWriteTime -Status Stable -Comment "Module de script"

   Name: PSScriptingInventory [C:\scripts\PSScriptingInventory]

LastUpdate             Status      Tasks        GitBranch          Age
----------             ------      -----        ---------          ---
6/19/2024 8:42:04 AM   Stable      {}                main    234.01:13
```

Créer un nouveau statut de projet. Les références PSDrive seront converties en chemins de système de fichiers. La propriété Âge est automatiquement calculée à partir de la valeur LastUpdate.

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

### -LastUpdate

Quand le projet a-t-il été travaillé pour la dernière fois ?

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: date

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Quel est le nom du projet ? La valeur par défaut est le nom du dossier actuel.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: current folder name
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Quel est le chemin du projet ?

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status

Quel est le statut du projet ? Les valeurs acceptées sont:
 Development
 Updating
 Stable
 AlphaTesting
 BetaTesting
 ReleaseCandidate
 Patching
 UnitTesting
 AcceptanceTesting
 Other

```yaml
Type: PSProjectStatus
Parameter Sets: (All)
Aliases:
Accepted values: Development, Updating, Stable, AlphaTesting, BetaTesting, ReleaseCandidate, Patching, UnitTesting, AcceptanceTesting, Other

Required: False
Position: Named
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
Position: Named
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

Quelle est la version du projet ? La valeur par défaut sera détectée à partir d'un manifeste de module s'il est trouvé.

```yaml
Type: Version
Parameter Sets: (All)
Aliases: version

Required: False
Position: Named
Default value: module version
Accept pipeline input: False
Accept wildcard characters: False
```

### -Comment

Entrez un commentaire facultatif. Cela pourrait être une étiquette git ou une indication sur le type de projet.

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

### -Force

Remplacer un fichier PSProjectStatus existant.

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

### -Tags

Quels tags voulez-vous attribuer à ce projet ?

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

Ce cmdlet prend en charge les paramètres communs : -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, et -WarningVariable. Pour plus d'informations, voir [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Aucune

## OUTPUTS

### PSProject

## NOTES

Cette commande a un alias de npstat.

En savoir plus sur PowerShell : http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSProjectStatus](Get-PSProjectStatus.md)

[Set-PSProjectStatus](Set-PSProjectStatus.md)

[Get-PSProjectReport](Get-PSProjectReport.md)
