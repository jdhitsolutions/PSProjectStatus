#localized string data for verbose messaging, errors, and warnings.

ConvertFrom-StringData @"
    addProperty = Adding property {0}
    appendTasks = Appending tasks
    RemoteRepositoryInfo = Creating remote repository information
    DetectedParameterSet = Detected parameter set {0}
    Ending = Ending PSProjectStatus module command
    ExistingWarning = $([char]27)[91mAn existing project status file was found. You must either delete the file or re-run this command with -Force.$([char]27)[0m
    FailPDF = Failed to open the help file. {0}. You can try opening the help as markdown.
    FilterNewer = Filtering for projects last updated within the last {0} days
    FilterOlder = Filtering for projects last updated in the more than {0} days ago
    FilterStatus = Filtering for status {0}
    FilterTag = Filtering by tag {0}
    FoundGit = Detected git branch {0}
    FoundProjects = Found {0} projects
    FoundTasks = Found {0} tasks
    GetGitBranch = Getting git branch information
    GetGitRemote = Getting remote git information
    GetStatus = Getting project status from {0}
    GetTaskID = Getting Task number {0}
    gitWarning = You must run this command from the root of a git repository
    missingJson = $([char]27)[91mCan't find psproject.json in the specified location {0}$([char]27)[0m
    NewInstance = Creating a new instance of the PSProject class
    NoGit = No git branch detected
    NoGitFolder =  Could not find .git folder in the current location
    NoGitRemote = No git remote detected
    NoTasks = No tasks found for this project
    NoTaskID =  $([char]27)[91mCould not find a task with an ID of {0} $([char]27)[0m
    OpenMarkdownHelp = Opening the help file as markdown
    OpenPDFHelp = Attempting to open {0} with the default PDF viewer
    ProcessPath = Processing PSProject path {0}
    ProcessProjects = Processing PSProjects under {0}
    ProcessTasks = Processing tasks in {0}
    PSVersion = Running under PowerShell version {0}
    ReplaceTasks = Replacing tasks
    RemoveTask = Removing task {0} [{1}]
    SetProperty = Setting property: {0}
    Starting = Starting PSProjectStatus module command
    TestGit = Testing for .git
    Updating = Updating PSProject {0}
    UpdateProperty = Updating property {0}
    UsingHost = Using PowerShell Host {0}
    UsingModule = Using module PSProjectStatus version {0}
    UsingOS = Running under Operating System {0}
    UsingPath = Using filesystem path {0}
    UsingSchema = Using schema path {0}
"@