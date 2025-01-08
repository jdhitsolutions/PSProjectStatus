Function Open-PSProjectStatusHelp {
    [CmdletBinding()]
    [OutputType('None')]
    Param( )
    DynamicParam {
        # This feature requires PowerShell 7
        If ($IsCoreClr) {

            $paramDictionary = New-Object -Type System.Management.Automation.RuntimeDefinedParameterDictionary

            # Defining parameter attributes
            $attributeCollection = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
            $attributes = New-Object System.Management.Automation.ParameterAttribute
            $attributes.ParameterSetName = '__AllParameterSets'
            $attributes.HelpMessage = 'Op[en the help file as markdown if running PowerShell 7'
            $attributeCollection.Add($attributes)

            # Adding a parameter alias
            $dynAlias = New-Object System.Management.Automation.AliasAttribute -ArgumentList 'md'
            $attributeCollection.Add($dynAlias)

            # Defining the runtime parameter
            $dynParam1 = New-Object -Type System.Management.Automation.RuntimeDefinedParameter('AsMarkdown', [Switch], $attributeCollection)
            $paramDictionary.Add('AsMarkdown', $dynParam1)

            return $paramDictionary
        } # end if
    } #end DynamicParam

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose -message $strings.Starting

        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
            _verbose -message ($strings.UsingModule -f $PSProjectStatusModule)
        }

        #write-debug "detected culture $((Get-Culture).Name)"
        if ($PSBoundParameters.ContainsKey('AsMarkdown')) {
            #need to accommodate the directory structure for this command
            #relative to the module root

            #test for localized help
            if (Test-Path -Path "$PSScriptRoot\..\..\$((Get-Culture).Name)\README.md") {
                $docPath = "$PSScriptRoot\..\..\$((Get-Culture).Name)\README.md"
            }
            else {
                $docPath = "$PSScriptRoot\..\..\README.md"
            }
        }
        else {
            #write-debug "Testing for $PSScriptRoot\..\..\$((Get-Culture).Name)\PSProjectStatus-Help.pdf"
            if (Test-Path -Path "$PSScriptRoot\..\..\$((Get-Culture).Name)\PSProjectStatus-Help.pdf") {
                #write-debug "Using localized help for $((Get-Culture).Name)"

                $docPath = "$PSScriptRoot\..\..\$((Get-Culture).Name)\PSProjectStatus-Help.pdf"
            }
            else {
                #write-debug "Using en-US help"
                $docPath = "$PSScriptRoot\..\..\PSProjectStatus-Help.pdf"
            }
        }
        #Write-Debug "using docpath $docPath"

    } #begin
    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        if ($PSBoundParameters.ContainsKey('AsMarkdown')) {
            _verbose -Message $strings.OpenMarkdownHelp
            _verbose -message $docPath
            Show-Markdown -Path $docPath
        }
        else {
            Try {
                _verbose -message ($strings.OpenPDFHelp -f $docPath)
                Invoke-Item -Path $docPath -ErrorAction Stop
            }
            Catch {
                Write-Warning ($strings.FailPDF -f $_.Exception.Message)
            }
        }
    } #process
    End {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'End'
        _verbose $strings.Ending
    } #end
}