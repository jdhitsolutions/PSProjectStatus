# Module manifest for module 'PSProjectStatus'

@{
    RootModule           = 'PSProjectStatus.psm1'
    ModuleVersion        = '0.3.0'
    CompatiblePSEditions = 'Desktop', 'Core'
    GUID                 = 'ec249544-dc4e-4e24-aae8-4281ec84f54d'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '(c) JDH Information Technology Solutions, Inc. All rights reserved.'
    Description          = 'A set of PowerShell tools for tracking module development status.'
    PowerShellVersion    = '5.1'

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    FormatsToProcess     = @('formats\psprojectstatus.format.ps1xml')
    FunctionsToExport    = 'Get-PSProjectStatus', "New-PSProjectStatus", "Set-PSProjectStatus"
    # AliasesToExport = ''

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{
        PSData = @{
                    Tags = @("modules", "scripting","project-management","project")
                    LicenseUri = 'https://github.com/jdhitsolutions/PSProjectStatus/blob/main/License.txt'
                    ProjectUri = 'https://github.com/jdhitsolutions/PSProjectStatus'
                    # IconUri = ''
                    #ReleaseNotes = ''
                    # Prerelease = ''
                    RequireLicenseAcceptance = $false
                    # ExternalModuleDependencies = @()
        } # End of PSData hashtable

    } # End of PrivateData hashtable
}

