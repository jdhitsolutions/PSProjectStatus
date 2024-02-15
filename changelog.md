# Changelog for PSProjectStatus

## v0.14.1

### Changed

- Updated `README`

### Added

- Added alias `nptask` for `New-PSProjectTask

## v0.14.0

### Fixed

- Updated commands to better store status path when using non-Windows systems. [Issue #11](https://github.com/jdhitsolutions/PSProjectStatus/issues/11)
- Updated `Set-PSProjectStatus` to insert empty arrays for Tasks and Tags when not specified.

### Changed

- Updated `New-PSProjectStatus` to add multiple tasks. [Issue #12](https://github.com/jdhitsolutions/PSProjectStatus/issues/12)
- Help updates.
- Updated `README`

## v0.13.1

### Fixed

- Fixed bug in `Set-PSProjectStatus` that was deleting existing tags.
-
## v0.13.0

### Added

- Added string data for private helper functions.
- Added exported variable `PSProjectANSI` to store ANSI escape sequences for color output in verbose messaging. This is a user-configurable setting.

### Changed

- Modified verbose output in the `Begin` block of module functions to only show metadata when the command is invoked directly. This will eliminate redundant metadata when a function is called from another function.
- Moved command color highlighting to the `_verbose` helper function. The function will detect the associated ANSI escape sequence for each command from `$PSProjectANSI` and apply it to the command name.
- Updated formatting file to display `Age` with out millisecond value.
- Updated `README.md`.

### Fixed

- Fixed missing string data item.
- Fixed wrong information in string data.

### Removed

- Removed alias `Update-PSProjectStatus` because it was conflicting with the VSCode  update extension.`

## v0.12.0

### Added

- Added support for tags to `New-PSProjectStatus`, `Set-PSProjectStatus`, and `Get-PSProjectReport`. Modified format file to display tags in the default list view. This also necessitated a change to the [JSON schema file](psproject.schema.json). [[Issue #8](https://github.com/jdhitsolutions/PSProjectStatus/issues/8)]
- Added localized string data file `psprojectstatus.psd1`
- Added a private function to display verbose messaging.
- Added a new formatted list view called `info` to display `Tasks`, `Tags`, and `Comment` properties.
- Added a custom property set called `Info` to display `Name`,`Status`,`Version`,`GitBranch`,`Tasks`,`Tags`, and `Comment` properties.
- Defined alias `Update-PSProjectStatus` for `Set-PSProjectStatus`.
- Added an exported variable, `PSProjectStatusModule` for the module version. This variable is used in verbose messaging. This necessitated using `Export-ModuleMember` in the root module file.

### Changed

- Modified format file for PSProjectStatus to display project name in `Cyan`. This applies to table and list views.
- Modified verbose, warning and debug messages to use localized string data.
- Modified JSON schema to require the `LastUpdated` property.
- Help updates.

### Fixed

- Fixed format files to not use ANSI escape sequences if the PowerShell ISE is detected.

## v0.11.1

### Fixed

- Added missing online help links.

## v0.11.0

### Fixed

- Removed hard-coded path reference in `Get-PSProjectReport`. ([Issue #9](https://github.com/jdhitsolutions/PSProjectStatus/issues/9))

### Changed

- Updated `README.md`.
- Updated `Set-PSProjectStatus` to use the current date time as the default for the `LastUpdate` parameter. __This is a potential breaking change.__
- Updated `New-PSProjectStatus`to not overwrite an existing file if found. Added a `-Force` parameter.
- Updated Verbose output in all commands.
- Help updates

### Added

- Added command `Get-PSProjectTask` which is based on a new class definition.
- Added custom format file `psprojecttask.format.ps1xml`
- Added commands `New-PSProjectTask` and `Remove-PSProjectTask`.

## v0.10.1

### Fixed

- Removed hard-coded path reference in `Get-PSProjectReport`. ([Issue #9](https://github.com/jdhitsolutions/PSProjectStatus/issues/9))

- General code cleanup

### Added

- Added missing online help links

## 0.10.0

### Added

- Added `Archive` as 'PSProjectStatus` enumeration value.
- Added command `Get-PSProjectReport`.

### Updated

- Modified `psprojectstatus.format.ps1xml` to display Archive status in orange using a custom ANSI sequence.
- Modified editor integration commands to recognize the `Archive` status.
- Updated help content.
- Updated `README.md`

## 0.9.2

- Another fix to handling no RemoteRepository settings in the JSON file.

## 0.9.1

- Update commands to use an empty array `[]` for `RemoteRepository` setting if nothing is detected.

## 0.9.0

- Insert `[]` for empty tasks and remote repositories.
- Update to property descriptions in the JSON schema.
- Set default `LastUpdate` value to use value from `Get-Date -format o`. This provides a consistent value between PowerShell versions. Although converting `Get-Date` to JSON will still work.
- Help updates.

## 0.8.1

- fixed version number.

## 0.8.0

- Added JSON schema file and update code to insert the schema reference into the `psproject.json` file.
- Modified the code to save the JSON file to store the `Status` as its string value. This makes the file compatible with the new schema.
- Updated `README.md`.

## 0.7.0

- Updated `Save()` method to specify UTF-8 file encoding for the JSON file.
- Updated module manifest.
- Updated missing online help links.

## 0.6.0

- Added `Comment` property to the `PSProject` class.
- Added `Comment` parameter to `New-PSProjectStatus` and `Set-PSProjectStatus`.
- Added alias property `Username` for `UpdateUser`.
- Suppressed error message from `New-PSProjectStatus` when the project folder isn't initialized as a git repository.
- Added `Update-PSProjectStatus` as function for VSCode and the PowerShell ISE.
- Added `Get-PSProjectGitStatus` with an alias of `gitstat`.
- Added a `RefreshAll()` method to the `PSProject` class. This will run all refresh methods __AND__ save the file.
- Help updates.
- Updated `README.md`.

## 0.5.0

- Added online help links.
- Added alias `gpstat` for `Get-PSProjectStatus`.
- Added alias `npstat` for `New-PSProjectStatus`.
- Added alias `spstat` for `Set-PSProjectStatus`.
- Added remote repository property. [Issue #5]( https://github.com/jdhitsolutions/PSProjectStatus/issues/5)
- Added project version property.  [Issue #6]( https://github.com/jdhitsolutions/PSProjectStatus/issues/6)
- Updated format ps1xml file adding `ProjectVersion` to the list view.
- Added property set `versionInfo` defined in `types\psprojectstatus.types.ps1xml`.
- Added methods to the `PSProject` class to manually update or refresh property values. This is helpful for update projects created before additional properties were added.
- Help updates.
- Updated `README.md`.

## v0.4.0

- Updated module commands to include an `UpdateUser` property.
- Help updates.
- Updated `README`.
- Published module to the PowerShell Gallery

## v0.3.0

- Update `README.md`
- Updated private data in the module manifest.
- Added parameter alias `add` to `Concatenate` in `Set-PSProjectStatus`.
- Added parameter alias `FullName` to `Path` in `Get-PSProjectStatus`.

## v0.2.0

- Modified commands to ignore `Age` type extension.
- Added format view for `Get-PSProjectStatus`.
- Modified `New-PSProjectStatus` to convert all paths to full filesystem paths and not PSDrives.
- Added additional status values.
- Added help documentation.
- Updated `psproject.format.ps1xml` to adjust table widths. Added a default list view.

## v0.1.0
## [Unreleased]
### Changed
- Updated documentation

