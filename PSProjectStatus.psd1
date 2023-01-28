# Module manifest for module 'PSProjectStatus'

@{
    RootModule           = 'PSProjectStatus.psm1'
    ModuleVersion        = '0.10.0'
    CompatiblePSEditions = 'Desktop', 'Core'
    GUID                 = 'ec249544-dc4e-4e24-aae8-4281ec84f54d'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) 2022-2023 JDH Information Technology Solutions, Inc. All rights reserved.'
    Description          = 'A set of PowerShell tools for tracking module development status. The module uses a JSON file to create a custom object with information about your module. You can use this internally to track the status of your module including a simple to-do tracker. This module was first described at https://jdhitsolutions.com/blog/powershell/8960/introducing-psprojectstatus/'
    PowerShellVersion    = '5.1'
    TypesToProcess       = @('types\psprojectstatus.types.ps1xml')
    FormatsToProcess     = @('formats\psprojectstatus.format.ps1xml')
    FunctionsToExport    = 'Get-PSProjectStatus', 'New-PSProjectStatus', 'Set-PSProjectStatus', 'Update-PSProjectStatus',
    'Get-PSProjectGitStatus','Get-PSProjectReport'
    AliasesToExport      = 'gpstat', 'npstat', 'spstat', 'gitstat'
    PrivateData          = @{
        PSData = @{
            Tags                     = @("modules", "scripting", "project-management", "project","psmodule")
            LicenseUri               = 'https://github.com/jdhitsolutions/PSProjectStatus/blob/main/License.txt'
            ProjectUri               = 'https://github.com/jdhitsolutions/PSProjectStatus'
            # IconUri = ''
            ReleaseNotes             = 'https://github.com/jdhitsolutions/PSProjectStatus/blob/main/changelog.md'
            RequireLicenseAcceptance = $false
        } # End of PSData hashtable
    } # End of PrivateData hashtable
}

