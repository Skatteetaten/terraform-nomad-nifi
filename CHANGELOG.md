# Changelog

## [0.4.1 UNRELEASED]
### Changed
- Removed expose-test in `nifi.hcl` for service nifi-registry. #34
- Refactored `on_pr_push_master.yml` (GitHub actions) with same structure as in `terraform-nomad-nifiregistry`. #34
- Added new step to run `make test-standalone` for example/standalone in `.github/workflows/on_pr_push_master.yml`  #42
## [0.4.0]
### Added
- Customized Makefile to receive arguments for GitHub authentication #50
- Added secrets (GitHub user and GitHub personal token) to Vault by Ansible playbooks (`terraform-nomad-nifi/dev/ansible` ) #50
- Added variables (repo and branch) to Consul Key Value Store #50

### Updated
- Updated tests with parameters #50
- Changed Ansible playbooks `01_put_secrets_vault.yml` and `02_put_variables_consul.yml`, such that they only execute for example/standalone_git. #50

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
