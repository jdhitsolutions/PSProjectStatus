# Changelog for PSProjectStatus

## [Unreleased]

## [0.15.0] - 2025-01-06

### Added

- Added command `Open-PSProjectStatusHelp` to open a PDF version of the `README` file.
- Updated help documentation.

### Changed

- Updated verbose messaging.
- Updated `README.md`.

### Fixed

- Fixed bug in JSON schema for required `RemoteRegistry` properties.
- Fixed layout errors in the changelog.

## [v0.14.1] - 2024-02-15

### Changed

- Updated `README`

### Added

- Added alias `nptask` for `New-PSProjectTask`.

## [v0.14.0] - 2024-01-21

### Fixed

- Updated commands to better store the status path when using non-Windows systems. [Issue #11](https://github.com/jdhitsolutions/PSProjectStatus/issues/11)
- Updated `Set-PSProjectStatus` to insert empty arrays for Tasks and Tags when not specified.

### Changed

- Updated `New-PSProjectStatus` to add multiple tasks. [Issue #12](https://github.com/jdhitsolutions/PSProjectStatus/issues/12)
- Help updates.
- Updated `README`

## [v0.13.1] - 2024-01-04

### Fixed

- Fixed a bug in `Set-PSProjectStatus` that was deleting existing tags.

## [v0.13.0] - 2024-01-02

### Added

- Added string data for private helper functions.
- Added exported variable `PSProjectANSI` to store ANSI escape sequences for color output in verbose messaging. This is a user-configurable setting.

### Changed

- Modified verbose output in the `Begin` block of module functions to only show metadata when the command is invoked directly. This will eliminate redundant metadata when a function is called from another function.
- Moved command color highlighting to the `_verbose` helper function. The function will detect the associated ANSI escape sequence for each command from `$PSProjectANSI` and apply it to the command name.
- Updated formatting file to display `Age` without millisecond value.
- Updated `README.md`.

### Fixed

- Fixed missing string data item.
- Fixed wrong information in string data.

### Removed

- Removed alias `Update-PSProjectStatus` because it was conflicting with the VSCode  update extension.`

## [v0.11.1] - 2023-12-22

### Fixed

- Added missing online help links.

## [v0.11.0] - 2023-12-22

### Fixed

- Removed hard-coded path reference in `Get-PSProjectReport`. ([Issue #9](https://github.com/jdhitsolutions/PSProjectStatus/issues/9))

### Changed

- Updated `README.md`.
- Updated `Set-PSProjectStatus` to use the current date time as the default for the `LastUpdate` parameter. __This is a potential breaking change.__
- Updated `New-PSProjectStatus` not to overwrite an existing file if found. Added a `-Force` parameter.
- Updated Verbose output in all commands.
- Help updates

### Added

- Added command `Get-PSProjectTask` which is based on a new class definition.
- Added custom format file `psprojecttask.format.ps1xml`
- Added commands `New-PSProjectTask` and `Remove-PSProjectTask`.

## [v0.10.1] - 2023-08-04

### Fixed

- Removed hard-coded path reference in `Get-PSProjectReport`. ([Issue #9](https://github.com/jdhitsolutions/PSProjectStatus/issues/9))

- General code cleanup

### Added

- Added missing online help links

## [0.10.0] - 2023-01-28

### Added

- Added `Archive` as 'PSProjectStatus` enumeration value.
- Added command `Get-PSProjectReport`.

### Updated

- Modified `psprojectstatus.format.ps1xml` to display Archive status in orange using a custom ANSI sequence.
- Modified editor integration commands to recognize the `Archive` status.
- Updated help content.
- Updated `README.md`

## [0.9.2] - 2023-01-24

### Fixed

- Another fix to handling no RemoteRepository settings in the JSON file.

## [0.9.1] - 2023-01-23

### Fixed

- Update commands to use an empty array `[]` for `RemoteRepository` setting if nothing is detected.

## [0.9.0] - 2022-10-05

### Changed

- Insert `[]` for empty tasks and remote repositories.
- Updated property descriptions in the JSON schema.
- Set default `LastUpdate` value to use the value from `Get-Date -format o`. This provides a consistent value between PowerShell versions. Although converting `Get-Date` to JSON will still work.
- Help updates.

## [0.8.1] - 2022-07-18

- fixed version number.

## [0.8.0] - 2022-07-18

### Added

- Added JSON schema file and updated code to insert the schema reference into the `psproject.json` file.

### Changed

- Modified the code to save the JSON file to store the `Status` as its string value. This makes the file compatible with the new schema.
- Updated `README.md`.

## [0.7.0] - 2022-04-13

### Changed

- Updated `Save()` method to specify UTF-8 file encoding for the JSON file.
- Updated module manifest.
- Updated missing online help links.

## [0.6.0] - 2022-03-29

### Added

- Added `Comment` property to the `PSProject` class.
- Added `Comment` parameter to `New-PSProjectStatus` and `Set-PSProjectStatus`.
- Added alias property `Username` for `UpdateUser`.
- Suppressed error message from `New-PSProjectStatus` when the project folder isn't initialized as a git repository.
- Added `Update-PSProjectStatus` as a function for VSCode and the PowerShell ISE.
- Added `Get-PSProjectGitStatus` with an alias of `gitstat`.
- Added a `RefreshAll()` method to the `PSProject` class. This will run all refresh methods __AND__ save the file.

### Changed

- Help updates.
- Updated `README.md`.

## [0.5.0] - 2022-03-26

### Added

- Added online help links.
- Added alias `gpstat` for `Get-PSProjectStatus`.
- Added alias `npstat` for `New-PSProjectStatus`.
- Added alias `spstat` for `Set-PSProjectStatus`.
- Added remote repository property. [Issue #5]( https://github.com/jdhitsolutions/PSProjectStatus/issues/5)
- Added project version property.  [Issue #6]( https://github.com/jdhitsolutions/PSProjectStatus/issues/6)
- Added property set `versionInfo` defined in `types\psprojectstatus.types.ps1xml`.
- Added methods to the `PSProject` class to manually update or refresh property values. This is useful for updating projects created before additional properties were added.

### Changed

- Help updates.
- Updated format ps1xml file adding `ProjectVersion` to the list view.
- Updated `README.md`.

## v0.4.0 - 2022-03-16

### Changed

- Updated module commands to include an `UpdateUser` property.
- Help updates.
- Updated `README`.
- Published module to the PowerShell Gallery

## v0.3.0 - 2022-03-15

### Added

- Added parameter alias `add` to `Concatenate` in `Set-PSProjectStatus`.
- Added parameter alias `FullName` to `Path` in `Get-PSProjectStatus`.

### Changed

- Update `README.md`
- Updated private data in the module manifest.

## v0.2.0 - 2022-03-15

### Added

- Added format view for `Get-PSProjectStatus`.
- Added additional status values.
- Added help documentation.

## Changed

- Modified commands to ignore `Age` type extension.
- Modified `New-PSProjectStatus` to convert all paths to full filesystem paths and not PSDrives.
- Updated `psproject.format.ps1xml` to adjust table widths. Added a default list view.

[Unreleased]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.15.0..HEAD
[0.15.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/vv0.14.1..v0.15.0
[v0.14.1]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.14.0..v0.14.1
[v0.14.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.13.1..v0.14.0
[v0.13.1]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.13.0..v0.13.1
[v0.13.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.12.0..v0.13.0
[v0.12.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.11.1..v0.12.0
[v0.11.1]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.11.0..v0.11.1
[v0.11.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.10.1..v0.11.0
[v0.10.1]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.10.0..v0.10.1
[0.10.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.9.2..v0.10.0
[0.9.2]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.9.1..v0.9.2
[0.9.1]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.9.0..v0.9.1
[0.9.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.8.1..v0.9.0
[0.8.1]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.8.0..v0.8.1
[0.8.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.7.0..v0.8.0
[0.7.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.6.0..b0.7.0
[0.6.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.5.0..v0.6.0
[0.5.0]: https://github.com/jdhitsolutions/PSProjectStatus/compare/v0.4.0..v0.5.0