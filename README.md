# PSProjectStatus

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSProjectStatus.png?style=for-the-badge&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSProjectStatus/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSProjectStatus.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/PSProjectStatus/)

This PowerShell module is designed to make it easier to manage your projects and modules. It provides a snapshot overview of the project's status. You can use this to quickly determine when you last worked on a module and what high-level tasks remain. Status information is stored in a JSON file that resides in the module's root directory. If you have initialized *git* for the module, the status will include the current branch.

## Installation

Install this module from the PowerShell Gallery.

```powershell
Install-Module PSProjectStatus
```

This module should work in Windows PowerShell and PowerShell 7.

## Class-Based

The status is based on a private class-based definition. The JSON file is used to create a `PSProject` object and update its properties.

```powershell
Class PSProject {
    [string]$Name = (Split-Path (Get-Location).path -Leaf)
    [string]$Path = (Convert-Path (Get-Location).path)
    [datetime]$LastUpdate = (Get-Date)
    [string[]]$Tasks
    [PSProjectStatus]$Status = "Development"
    [string]$GitBranch

    [void]Save() {
        $json = Join-Path -Path $this.path -ChildPath psproject.json
        $this | Select-Object -Property * -exclude Age | ConvertTo-Json | Out-File $json
    }
}
```

The class includes a status enumeration.

```powershell
enum PSProjectStatus {
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
}
```

At this time it is not possible to include a user-defined status. It is hoped that you can find something appropriate from the current status list.

The `Age` ScriptProperty is added to the object as a type extension.

```powershell
Update-TypeData -TypeName PSProject -MemberType ScriptProperty -MemberName Age -Value { (Get-Date) - $this.lastUpdate } -Force
```

## Creating a Project Status

To create a project status file, navigate to the module root and run [New-PSProjectStatus](docs/New-PSProjectStatus.md). The default status is `Development`

```dos
C:\Scripts\PSHelpDesk> New-PSProjectStatus

   Name: PSHelpDesk [C:\Scripts\PSHelpDesk]

LastUpdate             Status            Tasks                 GitBranch        Age
----------             ------            -----                 ---------        ---
3/15/2022 5:21:23 PM   Development                                   dev   00.00:00
```

You can update properties when you create the project status.

```dos
 C:\Scripts\PSHelpDesk> New-PSProjectStatus -LastUpdate (Get-Item .\*.psd1).lastwritetime -Status Updating -tasks "update help"

   Name: PSHelpDesk [C:\Scripts\PSHelpDesk]

LastUpdate             Status            Tasks                 GitBranch        Age
----------             ------            -----                 ---------        ---
2/20/2018 9:47:33 AM   Updating          {update help}               dev 1484.07:36
```

The command will create `psproject.json` in the root folder.

```json
{
  "Name": "PSHelpDesk",
  "Path": "C:\\Scripts\\PSHelpDesk",
  "LastUpdate": "2018-02-20T09:47:33-05:00",
  "Status": 1,
  "Tasks": [
    "update help"
  ],
  "GitBranch": "dev"
}
```

Note that the update time is formatted as a UTC string.

> If you are using *git* with your module you may want to add `psproject.json` to your `.gitignore` file.

## Getting a Project Status

The easiest way to view a project status is by using [Get-PSProjectStatus](docs/New-PSProjectStatus.md).

```dos
PS C:\scripts\PSCalendar> Get-PSProjectStatus


   Name: PSCalendar [C:\Scripts\PSCalendar]

LastUpdate             Status            Tasks                 GitBranch        Age
----------             ------            -----                 ---------        ---
3/3/2022 10:24:49 AM   Patching          {Update help docu...      2.9.0   12.07:07
```

If the host supports ANSI, a status of `Stable` will be displayed in Green. `Development` will be shown in Red and `Updating` in Yellow.

The module has a default list view.

```dos
PS C:\scripts\PSCalendar> Get-PSProjectStatus | format-list


   Project: PSCalendar [C:\Scripts\PSCalendar]


Status     : Patching
Tasks      : {Update help documentation, Issue #31, Issue #34, Issue #33}
GitBranch  : 2.9.0
LastUpdate : 3/3/2022 10:24:49 AM
```

This makes it easier to view tasks.

## Updating a Project Status

To update a project status, you could always manually update the JSON file in your script editor. Use this code snippet to get the datetime value in the proper format.

```powershell
Get-Date | ConvertTo=Json | Set-Clipboard
```

Paste the datetime value into the file.

The Status value is an integer indicating a private enumaration value.

```text
Development = 0
Updating = 1
Stable = 2
AlphaTesting = 3
BetaTesting = 4
ReleaseCandidate = 5
Patching = 6
UnitTesting = 7
AcceptanceTesting = 8
Other = 9
```

Or use the [Set-PSProjectStatus](docs/Set-PSProjectStatus.md) function.

```dos
PS C:\scripts\PSHelpDesk> Set-PSProjectStatus -LastUpdate (get-date) -Status Development -Tasks "add printer status function","revise user password function" -Concatenate


   Name: PSHelpDesk [C:\Scripts\PSHelpDesk]

LastUpdate             Status            Tasks                 GitBranch        Age
----------             ------            -----                 ---------        ---
3/15/2022 5:53:54 PM   Development  {update help, add...             dev   00.00:00
```

When defining tasks, use `-Concatenate` to append the tasks. Otherwise, tasks will be overwritten with the new value.

## Project Management

If you have many projects, you can use this module to manage all of them.

```powershell
Get-ChildItem -Path c:\scripts -Directory | Get-PSProjectStatus -WarningAction SilentlyContinue
```

![list projects](images/list-projects.png)

You will want to suppress Warning messages. If you are running PowerShell 7 and have the ConsoleGuiTools module installed, you can run a script like this:

```powershell
#requires -version 7.2
#requires -module Microsoft.PowerShell.ConsoleGuiTools

#open a project using the PSProject status

Import-Module PSProjectStatus -Force

$all = Get-ChildItem -Path C:\scripts -Directory |
Get-PSProjectStatus -WarningAction SilentlyContinue
$all | Sort-Object Status, LastUpdate |
Select-Object Path, Status, @{Name = "Tasks"; Expression = { $_.Tasks -join ',' } },
Gitbranch, LastUpdate |
Out-ConsoleGridView -Title "PSProject Management" -OutputMode Single |
ForEach-Object { code $_.path }
```

This will give you a list of projects.

![project list](images/manage-psproject.png)

You can select a single project, press Enter, and open the folder in VS Code. You could write a similar script for Windows PowerShell using `Out-Gridview`.

If no you longer want to track a project status, all you have to do is delete the JSON file.

## Road Map

These are a few things I'm considering.

+ Integration with VS Code
+ Integration with the PowerShell ISE
+ Add command aliases to make the functions easier to use in the console
+ Possibly capture the credentials of who last made a change. This might be useful in a development team scenario.

If you have any suggestions on how to extend this module or tips to others on how you are using it, please feel free to use the [Discussions](https://github.com/jdhitsolutions/PSProjectStatus/discussions) section of this module's Github repository.
