# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.3] - 2025-04-22

### Changed

- Fixed issue where the plugin was not doing anything with the app settings

## [0.1.2] - 2025-04-22

### Changed

- Fixed issue in fetch.lua for concatenating the azure command.

## [0.1.1] - 2025-04-22

### Changed

- Add option to enter resource group name
- Update README.md to include instructions for entering the resource group name.

## [0.1.0] - 2025-04-22

### Changed

- Renamed the plugin from `azfetch` to `azure` since it is now a general-purpose plugin for Azure.
- Added the fetch app settings functionality in a seperate lua file.
- Improved the README.md to provide better instructions on how to use the plugin.

## [0.0.3] - 2025-04-22

### Changed

- Improved README.md to make it easier to install the plugin.

## [0.0.2] - 2025-04-22

### Changed

- Fixed issue with loading the plugin due to mismatched folder name.

## [0.0.1] - 2025-04-22

### Added

- Initial release with the ability to fetch Azure Function App settings.
- Optional decryption of settings after fetching.
- Configurable keymap for triggering the fetch process.
