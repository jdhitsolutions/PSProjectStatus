Function Open-PSProjectStatusHelp {
    [CmdletBinding()]
    [OutputType('None')]
    Param(
        [Parameter(HelpMessage = 'Open the help file as markdown.')]
        [Alias('md')]
        [switch]$AsMarkdown
    )

    Begin {
        $PSDefaultParameterValues['_verbose:Command'] = $MyInvocation.MyCommand
        $PSDefaultParameterValues['_verbose:block'] = 'Begin'
        _verbose -message $strings.Starting

        if ($MyInvocation.CommandOrigin -eq 'Runspace') {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
            _verbose -message ($strings.UsingModule -f $ModuleVersion)
        }

        if ($AsMarkdown) {
            #need to accommodate the directory structure for this command
            #relative to the module root
            $docPath = "$PSScriptRoot\..\..\README.md"
        }
        else {
            $docPath = "$PSScriptRoot\..\..\PSProjectStatus-Help.pdf"
        }

    } #begin
    Process {
        $PSDefaultParameterValues['_verbose:block'] = 'Process'
        if ($AsMarkdown) {
            _verbose -Message $strings.OpenMarkdownHelp
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