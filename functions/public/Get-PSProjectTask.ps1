Function Get-PSProjectTask {
    [cmdletbinding()]
    [OutputType('psProjectTask')]

    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            HelpMessage = "Enter the parent path to the psproject.json file, e.g. c:\scripts\mymodule.")]
        [ValidateScript({ Test-Path $_ })]
        [alias("FullName")]
        [String]$Path = ".",
        [Parameter(HelpMessage = "Get a task by its ID number")]
        [ValidateNotNullOrEmpty()]
        [alias("ID")]
        [int]$TaskID
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
            Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Found $($in.tasks.count) tasks"
            if ($in.Tasks) {
                if ($TaskID -gt 0) {
                    Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Getting Task number $TaskID"
                }
                #define a project task ID number
                $i = 1
                foreach ($task in $in.tasks) {
                    $taskItem = [PSProjectTask]::New($task,$in.Path, $in.Name, $in.ProjectVersion)
                    $taskItem.TaskID = $i
                    if ($TaskID -AND ($TaskID -eq $i)) {
                        $taskItem
                    }
                    ElseIf (-Not $TaskID) {
                        $taskItem
                    }
                    $i++
                }
            }
            Else {
                Write-Warning "[$((Get-Date).TimeOfDay) PROCESS] No tasks found for this project."
            }
        }
        else {
            Write-Warning "[$((Get-Date).TimeOfDay) PROCESS] Can't find psproject.json in the specified location $cPath."
        }

    } #process

    End {

        Write-Verbose "[$((Get-Date).TimeOfDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Get-PSProjectTask