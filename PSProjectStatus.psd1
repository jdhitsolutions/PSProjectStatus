# Module manifest for module 'PSProjectStatus'

@{
    RootModule           = 'PSProjectStatus.psm1'
    ModuleVersion        = '0.16.0'
    CompatiblePSEditions = 'Desktop', 'Core'
    GUID                 = 'ec249544-dc4e-4e24-aae8-4281ec84f54d'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2022-2025 JDH Information Technology Solutions, Inc. All rights reserved.'
    Description          = 'A set of PowerShell tools for tracking module development status. The module uses a JSON file to create a custom object with information about your module. You can use this internally to track the status of your module including a simple to-do tracker. This module was first described at https://jdhitsolutions.com/blog/powershell/8960/introducing-psprojectstatus/'
    PowerShellVersion    = '5.1'
    TypesToProcess       = @('types\psprojectstatus.types.ps1xml')
    FormatsToProcess     = @('formats\psprojectstatus.format.ps1xml', '.\formats\psprojecttask.format.ps1xml')
    FunctionsToExport    = @(
        'Get-PSProjectStatus', 'New-PSProjectStatus',
        'Set-PSProjectStatus', 'Get-PSProjectGitStatus',
        'Get-PSProjectReport', 'Get-PSProjectTask',
        'New-PSProjectTask', 'Remove-PSProjectTask',
        'Update-PSProjectStatus', 'Open-PSProjectStatusHelp'
    )
    AliasesToExport      = @('gpstat', 'npstat', 'spstat', 'gitstat','nptask')
    PrivateData          = @{
        PSData = @{
            Tags                     = @('modules', 'scripting', 'project-management', 'project', 'psmodule', 'to-do')
            LicenseUri               = 'https://github.com/jdhitsolutions/PSProjectStatus/blob/main/License.txt'
            ProjectUri               = 'https://github.com/jdhitsolutions/PSProjectStatus'
            IconUri                  = 'https://raw.githubusercontent.com./jdhitsolutions/PSProjectStatus/main/images/psproject-icon.png'
            ReleaseNotes             = @'
## [0.16.0] - 2025-01-07

### Added

- Added localized verbose messaging, help documentation, and a version of the README help to French. Translations were done with GitHub CoPilot so I can't guarantee the quality.

### Changed

- Updated `README.md`.
- Updated help documentation.
- Revised PDF layout settings.

### Fixed

- Fixed `Get-PSProjectTask` bug. [Issue #14](https://github.com/jdhitsolutions/PSProjectStatus/issues/14).
- Fixed `Open-PSProjectStatusHelp` to make `-AsMarkdown` a dynamic parameter for PowerShell 7. [Issue #13](https://github.com/jdhitsolutions/PSProjectStatus/issues/13)
'@
            RequireLicenseAcceptance = $false
        }
    }
}

