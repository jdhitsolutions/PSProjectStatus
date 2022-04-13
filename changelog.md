# Changelog for PSProjectStatus

## 0.7.0

+ Updated `Save()` method to specify UTF-8 file encoding for the JSON file.
+ Updated module manifest.
+ Updated missing online help links.

## 0.6.0

+ Added `Comment` property to the `PSProject` class.
+ Added `Comment` parameter to `New-PSProjectStatus` and `Set-PSProjectStatus`.
+ Added alias property `Username` for `UpdateUser`.
+ Suppressed error message from `New-PSProjectStatus` when the project folder isn't initialized as a git repository.
+ Added `Update-PSProjectStatus` as function for VSCode and the PowerShell ISE.
+ Added `Get-PSProjectGitStatus` with an alias of `gitstat`.
+ Added a `RefreshAll()` method to the `PSProject` class. This will run all refresh methods __AND__ save the file.
+ Help updates.
+ Updated `README.md`.

## 0.5.0

+ Added online help links.
+ Added alias `gpstat` for `Get-PSProjectStatus`.
+ Added alias `npstat` for `New-PSProjectStatus`.
+ Added alias `spstat` for `Set-PSProjectStatus`.
+ Added remote repository property. [Issue #5]( https://github.com/jdhitsolutions/PSProjectStatus/issues/5)
+ Added project version property.  [Issue #6]( https://github.com/jdhitsolutions/PSProjectStatus/issues/6)
+ Updated format ps1xml file adding `ProjectVersion` to the list view.
+ Added property set `versionInfo` defined in `types\psprojectstatus.types.ps1xml`.
+ Added methods to the `PSProject` class to manually update or refresh property values. This is helpful for update projects created before additional properties were added.
+ Help updates.
+ Updated `README.md`.

## v0.4.0

+ Updated module commands to include an `UpdateUser` property.
+ Help updates.
+ Updated `README`.
+ Published module to the PowerShell Gallery

## v0.3.0

+ Update `README.md`
+ Updated private data in the module manifest.
+ Added parameter alias `add` to `Concatenate` in `Set-PSProjectStatus`.
+ Added parameter alias `fullname` to `Path` in `Get-PSProjectStatus`.

## v0.2.0

+ Modified commands to ignore `Age` type extension.
+ Added format view for `Get-PSProjectStatus`.
+ Modified `New-PSProjectStatus` to convert all paths to full filesystem paths and not PSDrives.
+ Added additional status values.
+ Added help documentation.
+ Updated `psproject.format.ps1xml` to adjust table widths. Added a default list view.

## v0.1.0

+ Initial module files
