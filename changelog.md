# Changelog for PSProjectStatus

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
