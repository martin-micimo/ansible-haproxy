# How to add to this log

All notable changes to this project shall be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Intended Effort Versioning (EffVer)](https://jacobtomlinson.dev/effver/).

All changes for a new version shall be in this format:

```code
## <VERSION> - <YEAR>-<MONTH>-<DAY>

### Added

- Added stuff

### Deprecated

- Soon to be removed feature

### Fixed

- Fixed stuff

### Changed

- Changed stuff

### Removed

- Removed stuff
```

If no points can be identified for any sub chapter it shall be removed in that entry.

# Changes for this role in reverse chronological order

## 1.4.0 - 2026-06-13

### Added

- Support for Ubuntu 26.04 including molecule testing
- Support for Fedora 44 and 43 including molecule testing
- New variable `haproxy_version_defaults` that replaces a bunch of other variables
- Testing was added to the Molecule run

### Fixed

- Outdated CHANGELOG.md
- Renamed `haproxy_debian_depentent_packages` to `haproxy_debian_dependent_packages` :facepalm:
- Restarting the Apache for testing was not taking care of distribution
- Testing happens after HAProxy is up now, so does the Molecule stop for inspection
- We do wait for the system to return if we have to restart because of SELinux
- Linting did not work properly, now it des

### Changed

- Much simpler way to get the `haproxy_version` variable filled with default values
- Deb822 format for the PPA repositories and finding the right signing key
- All Ansible task names are in double quotes now
- All variable names are prefixed with `haproxy_` now

## 1.3.0 - 2026-04-01

### Added

- Support for Debian 13 Trixie
- Support for AlmaLinux 10.1 Heliotrope Lion
- Support for AlmaLinux 9.7 Moss Jungle Cat
- Support for RockyLinux 10.1 Red Quartz
- Support for RockyLinux 9.7 Blue Onyx
- Support for HAProxy 3.3 in Ubuntu 24.04 Noble
- Dependency on Debian package python3-debian for ansible.builtin.deb822_repository

### Changed

- Default HAProxy version for RockyLinux 9.7 Blue Onyx from 2.4 => 2.8
- Default HAProxy version for RockyLinux 10.1 Red Quartz from 2.4 => 3.0
- Default HAProxy version for AlmaLinux 9.7 Moss Jungle Cat from 2.4 => 2.8
- Default HAProxy version for AlmaLinux 10.1 Heliotrope Lion from 2.4 => 3.0
- Use deb822 format for repo definitions and not use ansible.builtin.apt_repository anymore
- Download Repository GPG key directly and not use ansible.builtin.apt_key anymore

### Removed

- Support for AlmaLinux 9.0 Emerald Puma
- Support for AlmaLinux 9.1 Lime Lynx
- Support for AlmaLinux 9.2 Turquoise Kodkod
- Support for AlmaLinux 9.3 Shamrock Pampas Cat
- Support for AlmaLinux 9.4 Seafoam Ocelot
- Support for AlmaLinux 9.5 Teal Serval
- Support for RockyLinux 9.0
- Support for HAProxy 2.4 in Debian 10 Bullseye
- Support for HAProxy 2.4 in Ubuntu 20.04 Focal
- Dependency on Debian package software-properties-common

## 1.2.1 - 2025-07-21

### Added

- Default HAProxy version for docker is now 3.2.3 (9 July 2025)

### Fixed

- Make the docker-compose now checks if there are ports to add.

## 1.2.0 - 2025-07-21

### Added

- Default HAProxy Version in Debian Bookworm is now 3.2
- Default HAProxy Version in Debian Bullseye is now 3.1
- Default HAProxy Version in Ubuntu Noble is now 3.2
- Removed the use of the generic item variable in loops, so this role can be included without warnings.

### Fixed

- Debians PPAs are now more reliable because software-properties-common (big) gets installed
- There was a Variable mentioned in the README named haproxy_listener_vars, the right name is haproxy_listen_vars
- The Debian gpg key for https://haproxy.debian.net was changed

## 1.1.1 - 2025-03-03

### Added

- Default HAProxy Version in Docker mode is 3.0.8 now.

### Fixed

- Docker and Debian Tests.
- AlmaLinux Versions have been in wrong order in README

## 1.1.0 - 2025-03-01

### Added

- Support for HAProxy 3.0 (default version).
- Support for specifying the docker containers network_mode.
- Support for AlmaLinux 9.4 and 9.5.

### Fixed

- Molecule Tests.
- Docker Compose version is not supported in compose file anymore.
- Docker Compose was creating a separate network by default.

### Removed

- Support for Debian 10 Buster (because of too old python version for ansible).
- Support for Ubuntu 18.04. Bionic (because it is EOL).

## 1.0.12 - 2024-07-11

### Added

- Make the role show all diffs when templating with `ansible.builtin.template` by default.

## 1.0.11 - 2024-06-17

### Fixed

- unnecessary restarting docker compose when overwriting haproxy_docker_name

## 1.0.10 - 2024-05-26

### Fixed

- docker healthcheck default values.
- haproxy.cfg deployment directory was not working for docker mode.

## 1.0.9 - 2024-05-26

### Fixed

- Properly fixed config directory creating in docker mode.

## 1.0.8 - 2024-05-26

### Fixed

- Config directory structure in haproxy_mode docker not properly created.

## 1.0.7 - 2024-05-16

### Fixed

- Molecule role name
- Test for haproxy_installer

### Added

- Support for Ubuntu Noble Numbat 24.04

## 1.0.6 - 2024-04-06

### Fixed

- Spelling in the README

### Added

- Docker Container Healthcheck

## 1.0.5 - 2024-03-11

### Fixed

- README Badges
- Ansible Galaxy Role Name in Examples
- GitHub Workflow

## 1.0.4 - 2024-03-10

### Changed

- Switch to installing Ansible to Publish the Galaxy Role

## 1.0.3 - 2024-03-10

### Changed

- Switch to [Publish Ansible role to Galaxy](https://github.com/marketplace/actions/publish-ansible-role-to-galaxy) Action.

## 1.0.2 - 2024-03-10

### Fixed

- Wrong fields in GitHub Workflow

## 1.0.1 - 2024-03-10

### Fixed

- Run GitHub Workflow on an [existing Runner](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#choosing-github-hosted-runners)

## 1.0.0 - 2024-03-10

### Added

- Full functioning Ansible Role.
- Molecule Environment to Test the Role on all supported Distributions.
- GitHub Workflow for Ansible Galaxy Publication.
- Comprehensive README with Badges.
- Versioning Schema EffVer.
- CONTRIBUTION Guide.
- LICENSE.
