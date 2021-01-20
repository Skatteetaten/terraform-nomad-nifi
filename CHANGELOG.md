# Changelog

## [0.4.0 UNRELEASED]

- Increase time


## [0.3.0 ] 
### Added
- Created a new example `standalone_git` with NiFi container connected to a NiFi Registry container with git integration (Github) #35
- Created README in standalone #38
### Changed
- Updated Makefile to execute example `standalone` or `standalone_git`#35
- Updated `Vagrantfile` and `dev/ansible/01_run_terraform.yml` to handle input argument `mode` from Makefile. #35

### Deleted
- Deleted unused files in repo `terraform-nomad-nifi` #40
- Refactored structure #40
- Removed unused variables as nomad_host_volume and use_host_volume #38

## [0.2.0]
### Added
- Added health checks for nifi service #17
- Added health check for nifi-registry in nifi #28
- Added upstream to nifi registry #26
- Added make proxy-nifi-reg #26

### Changed
- Removed unused files #19
- Update vagrant-box, `version = ">= 0.9, < 0.10"` #32

## [0.1.0]

### Added
- Added 02_run_terraform.yml #6
- Created a simple example for nifi #2
- Added documentation for [example/standalone](example/standalone) in README.md #8

### Changed
- Update vagrant-box, `version = ">= 0.7, < 0.8"` #16
