[![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white)](https://www.debian.org)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![RockyLinux](https://img.shields.io/badge/RockyLinux-10B981?style=for-the-badge&logo=rockylinux&logoColor=white)](https://rockylinux.org/)
[![AlmaLinux](https://img.shields.io/badge/AlmaLinux-000000?style=for-the-badge&logo=almalinux&logoColor=white)](https://almalinux.org/)
[![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=Prometheus&logoColor=white)](https://prometheus.io/)
[![YAML](https://img.shields.io/badge/yaml-%23CB171E.svg?style=for-the-badge&logo=yaml&logoColor=white)](https://yaml.org/)
[![Jinja](https://img.shields.io/badge/jinja-%23B41717.svg?style=for-the-badge&logo=jinja&logoColor=white)](https://palletsprojects.com/p/jinja/)
[![Bash](https://img.shields.io/badge/bash-%234EAA25.svg?style=for-the-badge&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)

[![Issues](https://img.shields.io/github/issues/martin-micimo/ansible-haproxy.svg)](https://github.com/martin-micimo/ansible-haproxy/issues/)
[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/martin-micimo/ansible-haproxy.svg)](https://github.com/martin-micimo/ansible-haproxy/pulls/)

[![Ansible Role Downloads](https://img.shields.io/ansible/role/d/martin-micimo/haproxy)](https://galaxy.ansible.com/ui/standalone/roles/martin-micimo/haproxy/)
[![GPLv3 License](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[![Latest Release](https://img.shields.io/github/v/release/martin-micimo/ansible-haproxy)](https://github.com/martin-micimo/ansible-haproxy/releases)
[![EffVer Versioning](https://img.shields.io/badge/version_scheme-EffVer-0097a7)](https://jacobtomlinson.dev/effver)

# Ansible HAProxy Role

This Role lets you Setup, Configure and Maintain a [HAProxy](https://www.haproxy.org/) virtual LoadBalancer with [Ansible](https://www.ansible.com/).

## What is it good for

- Situations where you want/need to customize every aspect of the HAProxy Configuration.
- Running a newer HAProxy than your Linux Distribution has available by Default on a [System](#system-mode).
- Running HAProxy with [Docker Compose](#docker-mode).
- Building a customized Docker Image for the use in an orchestrated Environment like [Kubernetes](https://kubernetes.io).
- When you want to learn about HAProxy Setups and Ansible Galaxy Roles.

## What is it not for

- Very simple HAProxy Setups running directly on a Server. You should instead just install the HAProxy Package and template the Configuration yourself.
- Very simple HAProxy Kubernetes Setups. You should use the [official HAProxy Docker Image](https://hub.docker.com/_/haproxy/) instead.

# Table of Contents

- [Features](#features)
- [Supported Distributions](#supported-distributions)
- [Role Modes](#role-modes)
  - [System Mode](#system-mode)
  - [Docker Mode](#docker-mode)
- [HAProxy Configuration](#haproxy-configuration)
- [Requirements](#requirements)
- [Role Steering Variables](#role-steering-variables)
- [Dependencies](#dependencies)
- [Tips and Tricks](#tipps-and-tricks)
- [License](#license)
- [Authors](#authors)

Separate Markdown files:

- [SYSTEM_MODE.md](SYSTEM_MODE.md) - Details about `haproxy_mode: system` (default)
- [DOCKER_MODE.md](DOCKER_MODE.md) - Details about `haproxy_mode: docker`
- [CONFIGURATION.md](CONFIGURATION.md) - Details about configuring HAProxy
- [EXAMPLES.md](EXAMPLES.md) - Example Ansible Playbooks

# Features

- [x] All available Sections of the haproxy.cfg can be fully templated by using customizable Variables.
- [x] Works on many Distributions.
- [x] Supports building a customized Docker Image and running it.
- [x] Customizable Error pages.
- [x] HAProxy Configmap Support.
- [X] LUA Script Support.
- [X] Default Prometheus Metrics.
- [X] Support for Firewalld, SELinux and Sysctl Settings.

# Supported Distributions

- [x] Debian 13 Trixie
- [x] Debian 12 Bookworm
- [x] Debian 11 Bullseye
- [x] Ubuntu 24.04 Noble Numbat
- [x] Ubuntu 22.04 Jammy Jellyfish
- [x] Ubuntu 20.04 Focal Fossa
- [x] Rocky Linux 9.7 Blue Onyx
- [x] Rocky Linux 10.1 Red Quartz
- [x] Alma Linux 9.7 Moss Jungle Cat
- [x] Alma Linux 10.1 Heliotrope Lion

# Role Modes

Currently this Role Supports two Modes to run HAProxy:

- [System](#system-mode): HAProxy runs as a process on a Server.
- [Docker](#docker-mode): Allows you to run/build HAProxy in/for a Docker/Kubernetes Environment.

The behavior is set by this Variable:

|Name|Default|Description|
|:--|:--|:--|
|`haproxy_mode`|system|Can be one of: system, docker|

## System Mode

This part of the documentation exists in [SYSTEM_MODE.md](SYSTEM_MODE.md)

## Docker Mode

This part of the documentation exists in [DOCKER_MODE.md](DOCKER_MODE.md)

# HAProxy Configuration

This part of the documentation exists in [CONFIGURATION.md](CONFIGURATION.md)

# Role Steering Variables

With these variables you can steer the execution of this role.

|Name|Optional|Mode|Default|Description|
|:--|:--|:--|:--|:--|
|`haproxy_mode`|false|both|"system"|Can be one of `system` or `docker`|
|`haproxy_helper_scripts_enabled`|true|both|false|Install the Helper Scripts|
|`haproxy_dhparams_create`|true|both|false|Create a dhparams File|
|`haproxy_dhparams_speedup`|true|both|false|Speedup Entropy Generation on older Kernels|
|`haproxy_config_file`|true|both|"haproxy.cfg"|The Name of the HAProxy Configuration|
|`haproxy_docker_build`|true|docker|false|Select if you want to build a Docker Image|
|`haproxy_docker_push`|true|docker|false|Select if you want to push the Image to a Registry|
|`haproxy_docker_compose`|true|docker|false|Select if you want to run the Image with Docker Compose|
|`haproxy_service_state`|true|system|"started"|The Condition the HAProxy should be set to|
|`haproxy_config_logrotate`|true|system|false|Select if you want to change the Logging to rsyslogd and Configure Log rotation|
|`haproxy_selinux_enabled`|true|system|false|Select if you want to configure SELinux Settings|
|`haproxy_firewalld_enabled`|true|system|false|Select if you want to configure Firewalld Settings|
|`haproxy_sysctl_enabled`|true|system|false|Select if you want to configure Kernel Parameters|
|`haproxy_show_debug`|true|system|false|If you enable this some Debug Information is shown|
|`haproxy_show_template_diffs`|true|both|true|By default haproxy is showing the diffs of the templates|
|`haproxy_testing_mode`|true|both|false|If you enable this a fake TLS Certificate will be created and Apache will be installed|
|`haproxy_molecule_test`|false|system|true|Only used for Molecule Tests where this is `true`|

# Dependencies

|Mode|Collections|Executables|Plugins|
|:--|:--|:--|:--|
|[System](#system-mode)|-|-|-|
|[System](#system-mode) with [SELinux](#selinux)|ansible.posix<br>community.general|-|-|
|[System](#system-mode) with `haproxy_testing_mode`|community.crypto|-|-|
|[Docker](#docker-mode)|ansible.posix<br>community.general<br>community.docker|docker|docker-compose|

This Role is not dependent on any other Role if used in [System Mode](#system-mode).
In [Docker Mode](#docker-mode) you need to make sure you have Docker (with the docker-compose-plugin) Installed.

# Tips and Tricks

- Find Proper TLS Certificate Settings in the [Moz://a SSL Configuration Generator](https://ssl-config.mozilla.org/)
- Test your TLS Configuration Strength with [Qualys SSL Labs](https://www.ssllabs.com/ssltest/)
- If you want to deploy a not functional haproxy.cfg overwrite the Variable `haproxy_validation_command` with "/bin/true %s". You also want to set `haproxy_service_state` or `haproxy_docker_compose` accordingly.
- Always make sure to only connect HTTP Mode Frontends to HTTP Mode Backends and only TCP Frontends to TCP Backends. I write the `mode` at the beginning of these Definitions and set it explicitly everywhere.
- Do not put your `dhparams.pem` File into a dynamically loaded certs Directory. HAProxy can currently not deal with that.

# License

This Work is licensed under the [GPLv3 License](https://www.gnu.org/licenses/gpl-3.0.de.html)

# Authors

Created in 2024 by [Martin Meier](https://micimo.de)
