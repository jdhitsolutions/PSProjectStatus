---
external help file: PSProjectStatus-help.xml
Module Name: PSProjectStatus
online version: https://bit.ly/3jSB1hH
schema: 2.0.0
---

# Get-PSProjectGitStatus

## SYNOPSIS

Get git project status.

## SYNTAX

```yaml
Get-PSProjectGitStatus [<CommonParameters>]
```

## DESCRIPTION

Presumably you are using git to manage your project. If so, some git-related information is included in the PSProjectStatus output. Get-PSProjectGitStatus is intended to provide more git-specific details. You should run this command in the root of your project directory. If the project is not a git repository, nothing will be returned.

## EXAMPLES

### Example 1

```powershell
S C:\Scripts\PSProjectStatus> Get-PSProjectGitStatus

Name            Branch LastCommit           Remote
----            ------ ----------           ------
PSProjectStatus 0.6.0  3/29/2022 5:23:20 PM @{RemoteName=origin; LastPush=3/26/2022 10:36:00 AM}
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSProjectGit

## NOTES

This command has an alias of gitstat.

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSProjectStatus](Get-PSProjectStatus.md)
