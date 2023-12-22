Function New-PSProjectTask {
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('None','psProjectTask')]
    [alias('alias')]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the task description.")]
        [ValidateNotNullOrEmpty()]
        [string]$TaskDescription,
        [Parameter(
            HelpMessage = "Enter the parent path to the psproject.json file, e.g. c:\scripts\mymodule.")]
        [ValidateScript({ Test-Path $_ })]
        [alias("FullName")]
        [String]$Path = ".",
        [switch]$PassThru
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Running under PowerShell version $($PSVersionTable.PSVersion)"
        Write-Verbose "[$((Get-Date).TimeOfDay) BEGIN  ] Using PowerShell Host $($Host.Name)"
    } #begin

    Process {
        $cPath = Convert-Path $Path
        $json = Join-Path $cPath -ChildPath psproject.json
        If (Test-Path -path $json) {
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Processing tasks in $json"
            $in = Get-Content -Path $json | ConvertFrom-Json
            $in.Tasks+=$TaskDescription
            $in.LastUpdate = Get-Date

            $in | ConvertTo-Json | Out-File -FilePath $json
            if ($PassThru) {
                Get-PSProjectTask | where TaskDescription  -eq $TaskDescription
            }
        }
        else {
            Write-Warning "[$((Get-Date).TimeOfDay) PROCESS] Can't find psproject.json in the specified location $cPath."
        }

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close New-PSProjectStatus