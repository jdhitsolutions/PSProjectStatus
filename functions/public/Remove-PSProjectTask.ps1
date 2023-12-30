Function Remove-PSProjectTask {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None')]
    [alias('alias')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the task ID")]
        [ValidateNotNullOrEmpty()]
        [Alias("ID")]
        [Int]$TaskID,
        [Parameter(
            HelpMessage = "Enter the parent path to the psproject.json file, e.g. c:\scripts\mymodule.")]
        [ValidateScript({ Test-Path $_ })]
        [alias("FullName")]
        [String]$Path = "."
    )

    Begin {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "Begin"
        _verbose -message $strings.Starting
        if ($MyInvocation.CommandOrigin -eq "Runspace") {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingModule -f $PSProjectStatusModule)
        }
    } #begin

    Process {
        $PSDefaultParameterValues["_verbose:block"] = "Process"
        $cPath = Convert-Path $Path
        $json = Join-Path $cPath -ChildPath psproject.json
        If (Test-Path -path $json) {
            _verbose ($strings.ProcessTasks -f $json)
            $in = Get-Content -Path $json | ConvertFrom-Json
            $t = Get-PSProjectTask -id $TaskID
            if ($t.TaskID -gt 0) {
                _verbose ($strings.RemoveTask -f $t.TaskDescription,$t.TaskID)
                $updated = $in.tasks | Where-Object {$_ -ne $t.TaskDescription}
                $in.Tasks = $updated

                $in.LastUpdate = Get-Date
                $in | ConvertTo-Json | Out-File -FilePath $json
            }
            else {
                Write-Warning ($strings.NoTaskID -f $TaskID)
            }
        }
        else {
            Write-Warning ($strings.missingJson -f $cPath)
        }

    } #process

    End {
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "End"
        _verbose $strings.Ending
    } #end

} #close New-PSProjectStatus



Register-ArgumentCompleter -CommandName Remove-PSProjectTask -ParameterName TaskID -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    #PowerShell code to populate $WordToComplete
    Get-PSProjectTask | ForEach-Object {
            # completion text,listitem text,result type,Tooltip
            [System.Management.Automation.CompletionResult]::new($_.TaskID, $_.TaskID, 'ParameterValue', $_.TaskDescription)
        }
}