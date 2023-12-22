Function Remove-PSProjectTask {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipelineByPropertyName,
            HelpMessage = 'Enter the task ID')]
        [ValidateNotNullOrEmpty()]
        [Alias('ID')]
        [Int[]]$TaskID,
        [Parameter(
            HelpMessage = 'Enter the parent path to the psproject.json file, e.g. c:\scripts\mymodule.')]
        [ValidateScript({ Test-Path $_ })]
        [alias('FullName')]
        [String]$Path = '.'
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell Host $($Host.Name)"
        $cPath = Convert-Path $Path
        $json = Join-Path $cPath -ChildPath psproject.json
        If (Test-Path -Path $json) {
            Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Processing tasks in $json"
            $in = Get-Content -Path $json | ConvertFrom-Json
        }
        else {
            Write-Warning "[$((Get-Date).TimeOfDay) BEGIN  ] Can't find psproject.json in the specified location $cPath."
        }
    } #begin

    Process {
        If ($in) {
            foreach ($item in $TaskID) {
                $t = Get-PSProjectTask -id $item
                if ($t.TaskID -gt 0) {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Removing task $($t.TaskDescription) [$($t.TaskID)]"
                    $updated = $in.tasks | Where-Object { $_ -ne $t.TaskDescription }
                    $in.Tasks = $updated
                }
                else {
                    Write-Warning "Could not find a task with an ID of $TaskID"
                }
            } #foreach item
        } #if $in

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Saving changes to $json"
        $in.LastUpdate = Get-Date
        $in | ConvertTo-Json | Out-File -FilePath $json
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
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