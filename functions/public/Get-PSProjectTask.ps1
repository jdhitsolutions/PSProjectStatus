Function Get-PSProjectTask {
    [cmdletbinding()]
    [OutputType('PSProjectTask')]

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
        $PSDefaultParameterValues["_verbose:Command"] = $MyInvocation.MyCommand
        $PSDefaultParameterValues["_verbose:block"] = "Begin"
        $PSDefaultParameterValues["_verbose:ANSI"] = "[1;38;5;10m"
        _verbose -message $strings.Starting
        if ($MyInvocation.CommandOrigin -eq "Runspace") {
            #Hide this metadata when the command is called from another command
            _verbose -message ($strings.PSVersion -f $PSVersionTable.PSVersion)
            _verbose -message ($strings.UsingHost -f $host.Name)
            _verbose -message ($strings.UsingOS -f $PSVersionTable.OS)
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
            _verbose ($strings.FoundTasks -f $in.tasks.count)
            if ($in.Tasks) {
                if ($TaskID -gt 0) {
                    _verbose ($strings.GetTaskID -f $TaskID)
                }
                #define a project task ID number
                $i = 1
                foreach ($task in $in.tasks) {
                    #6 Jan 2024 Fix task constructor. Issue #14
                    #$taskItem = [PSProjectTask]::New($task,$in.Path,$in.Name,$in.ProjectVersion)
                    $taskItem = [PSProjectTask]::New($in.Name)
                    $taskItem.TaskDescription = $task
                    $taskItem.Path = $in.Path
                    $taskItem.ProjectName = $in.Name
                    #$taskItem.ProjectVersion = $in.ProjectVersion #>
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
                Write-Warning $strings.NoTasks

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

} #close Get-PSProjectTask