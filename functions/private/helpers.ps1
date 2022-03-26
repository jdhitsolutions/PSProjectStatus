#these are the module's private helper functions

function _getRemote {
    [cmdletbinding()]
    Param()

    $remotes = git remote -v
    if ($remotes) {
        foreach ($remote in $remotes) {
            $split = $remote.split()
            $Name = $split[0]
            $Url = $split[1]
            $Mode = $split[2].replace("(","").Replace(")","")
            [PSProjectRemote]::new($name,$url,$mode)

        } #foreach
    } #if remotes found
}