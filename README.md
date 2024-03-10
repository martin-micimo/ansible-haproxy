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

[![CI](https://github.com/martin-micimo/ansible-haproxy/workflows/Anible+Galaxy+Publish/badge.svg?event=push)](https://github.com/martin-micimo/ansible-haproxy/actions?query=Anible+Galaxy+Publish)
[![Actions Status](https://github.com/martin-micimo/ansible-haproxy/workflows/Molecule/badge.svg)](https://github.com/martin-micimo/ansible-haproxy/actions)
[![Issues](https://img.shields.io/github/issues/martin-micimo/ansible-haproxy.svg)](https://github.com/martin-micimo/ansible-haproxy/issues/)
[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/martin-micimo/ansible-haproxy.svg)](https://github.com/martin-micimo/ansible-haproxy/pulls/)

[![Galaxy](https://img.shields.io/badge/galaxy-martin-micimo.haproxy-blue.svg?style=flat-square)](https://galaxy.ansible.com/ui/standalone/roles/martin-micimo/haproxy)
[![Ansible Role Downloads](https://img.shields.io/ansible/role/d/martin-micimo/haproxy)](https://galaxy.ansible.com/ui/standalone/roles/martin-micimo/haproxy/)
[![GPLv3 License](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[![Latest Release](https://img.shields.io/github/v/release/micimo-gmbh/ansible-haproxy)](https://github.com/micimo-gmbh/ansible-haproxy/releases)
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

- Very simple HAProxy Setups running directly on a Server. You should instead just install the haproxy Package and template the Configuration yourself.
- Very simple HAProxy Kubernetes Setups. You should use the [official HAProxy Docker Image](https://hub.docker.com/_/haproxy/) instead.

# Table of Contents

- [Features](#features)
- [Supported Distributions](#supported-distributions)
- [Role Modes](#role-modes)
  - [System Mode](#system-mode)
    - [Version Matrix](#version-matrix)
      - [Debian](#debian)
      - [Ubuntu](#ubuntu)
      - [RockyLinux](#rockylinux)
      - [AlmaLinux](#almalinux)
    - [SELinux](#selinux)
    - [Firewalld](#firewalld)
    - [Sysctl](#sysctl)
    - [Helper Scripts](#helper-scripts)
  - [Docker Mode](#docker-mode)
    - [Supported Versions](#supported-versions)
    - [Building, Naming, Tagging and Pushing of the Image](#building-naming-tagging-and-pushing-of-the-image)
    - [Running the Image localy](#running-the-image-localy)
    - [Run a prebuild Image](#run-a-prebuild-image)
- [HAProxy Configuration](#haproxy-configuration)
  - [Default Configuration](#default-configuration)
  - [TLS Certificates](#tls-certificates)
  - [Logging](#logging)
  - [Secrets](#secrets)
  - [Metrics](#metrics)
  - [Error Files](#error-files)
  - [Configmaps](#configmaps)
  - [LUA Files](#lua-files)
- [Requirements](#requirements)
- [Role Steering Variables](#role-steering-variables)
- [Dependencies](#dependencies)
- [Example Playbooks](#example-playbooks)
  - [Playbook System Simple](#playbook-system-simple)
  - [Playbook System Advanced](#playbook-system-advanced)
  - [Playbook Docker Compose](#playbook-docker-compose)
  - [Playbook Docker Push](#playbook-docker-push)
  - [Playbook Docker official Image](#playbook-docker-official-image)
- [Tipps and Tricks](#tipps-and-tricks)
- [License](#license)
- [Authors](#authors)

# Features

- [x] All available Sections of the haproxy.cfg can be fully templated by using customizable Variables.
- [x] Works on many Distributions.
- [x] Supports building a customized Docker Image and running it.
- [x] Customizable Errorpages.
- [x] HAProxy Configmap Support.
- [X] LUA Script Support.
- [X] Default Prometheus Metrics.
- [X] Support for Firewalld, SELinux and sysctl Settings.

# Supported Distributions

- [ ] Debian 13 Trixie
- [x] Debian 12 Bookworm
- [x] Debian 11 Bullseye
- [x] Debian 10 Buster
- [ ] Ubuntu 24.04 Noble Numbat
- [x] Ubuntu 22.04 Jammy Jellyfish
- [x] Ubuntu 20.04 Focal Fossa
- [x] Ubuntu 18.04 Bionic Beaver
- [x] Rocky Linux 9 Blue Onyx
- [x] Alma Linux 9.3 Shamrock Pampas Cat
- [x] Alma Linux 9.2 Turquoise Kodkod
- [x] Alma Linux 9.1 Lime Lynx
- [x] Alma Linux 9.0 Emerald Puma

# Role Modes

Currently this Role Supports two Modes to run HAProxy:

- [System](#system-mode): Haproxy runs as a process on a Server.
- [Docker](#docker-mode): Allows you to run/build HAProxy in/for a Docker/Kubernetes Environment.

The behavior is set by this Variable:

|Name|Default|Description|
|:--|:--|:--|
|`haproxy_mode`|system|Can be one of: system, docker|

## System Mode

In System Mode this Role assumes
- ... that the Installation of the HAProxy Package will create a HAProxy User (normaly haproxy) that the Process will run in.
  - You can modify the `haproxy_user` and `haproxy_group` Variable if this is not the case.
  - This Role does not cover the Creation of this User.
- ... that the Service on the System will be managed by Systemd.
- ... that you have SELinux set up already if you want to use it in this Role.
- ... that you have FirewallD set up already if you want to use it in this Role.

## Version Matrix

Look [here](https://haproxy.debian.net/) for Installation Instructions for Debian & Ubuntu Distributions. For RedHat Compatible Distributions, there are only the Default Versions at the Moment.

You can overwrite the Version with the `haproxy_version` Variable, but make sure that the `haproxy_versions` Variable in `defaults/main/versions.yml` also includes that Version on your Distribution.

If you want to modify the default Versions for multiple Distributions, you can do so with the `haproxy_<DISTRIBUTION>_<RELEASE>_default_version` Variables.

### Debian

|Version|End of Life|Debian 12|Debian 11|Debian 10|
|:--|:--|:--|:--|:--|
|[3.0](http://git.haproxy.org/?p=haproxy.git)|2029-Q2 (LTS)|-|-|-|
|[2.9](http://git.haproxy.org/?p=haproxy.git)|2025-Q1 (stable)|Supported|-|-|
|[2.8](http://git.haproxy.org/?p=haproxy-2.8.git)|2028-Q2 (LTS)|**Role Default**|**Role Default**|-|
|[2.6](http://git.haproxy.org/?p=haproxy-2.6.git)|2027-Q2 (LTS)|OS Default|Supported|**Role Default**|
|[2.4](http://git.haproxy.org/?p=haproxy-2.4.git)|2026-Q2 (LTS)|-|OS Default|Supported|
|[2.2](http://git.haproxy.org/?p=haproxy-2.2.git)|2025-Q2 (critical fixes only)|-|Supported|Supported|
|[2.0](http://git.haproxy.org/?p=haproxy-2.0.git)|2024-Q2 (critical fixes only)|-|-|Supported|
|[1.8](http://git.haproxy.org/?p=haproxy-1.8.git)|2022-Q4 (EOL!)|-|-|OS Default|

### Ubuntu

|Version|End of Life|Ubuntu 22|Ubuntu 20|Ubuntu 18|
|:--|:--|:--|:--|:--|
|[3.0](http://git.haproxy.org/?p=haproxy.git)|2029-Q2 (LTS)|-|-|-|
|[2.9](http://git.haproxy.org/?p=haproxy.git)|2025-Q1 (stable)|Supported|Supported|-|
|[2.8](http://git.haproxy.org/?p=haproxy-2.8.git)|2028-Q2 (LTS)|**Role Default**|**Role Default**|-|
|[2.6](http://git.haproxy.org/?p=haproxy-2.6.git)|2027-Q2 (LTS)|Supported|Supported|**Role Default** PPA unreliable|
|[2.4](http://git.haproxy.org/?p=haproxy-2.4.git)|2026-Q2 (LTS)|Supported|Supported|PPA unreliable|
|[2.2](http://git.haproxy.org/?p=haproxy-2.2.git)|2025-Q2 (critical fixes only)|OS Default|Supported|PPA unreliable|
|[2.0](http://git.haproxy.org/?p=haproxy-2.0.git)|2024-Q2 (critical fixes only)|-|OS Default|Supported|
|[1.8](http://git.haproxy.org/?p=haproxy-1.8.git)|2022-Q4 (EOL!)|-|-|OS Default|

### RockyLinux

|Version|End of Life|9|
|:--|:--|:--|
|[2.4](http://git.haproxy.org/?p=haproxy-2.4.git)|2026-Q2 (LTS)|OS Default|

### AlmaLinux

|Version|End of Life|9.3|9.2|9.1|9.0|
|:--|:--|:--|:--|:--|:--|
|[2.4](http://git.haproxy.org/?p=haproxy-2.4.git)|2026-Q2 (LTS)|OS Default|OS Default|OS Default|OS Default|

### SELinux

:warning: If you want to use SELinux Settings, this Role assumes, that you already have SELinux installed and enabled on the System. For more complicated Setups I would suggest using a dedicated Role.

The following Variables will give you Control over SELinux Settings:

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_selinux_enabled`|false|Lets you enable SELinux Support|
|`haproxy_selinux_packages`|['python3-selinux',<br>'python3-sepolicy',<br>'selinux-utils',<br>'selinux-basics',<br>'selinux-policy-default']|Packages to install|
|`haproxy_selinux_ports`|[]|List of Ports to open with SELinux for HAProxy|
|`haproxy_selinux_flags`|[]|**Experimental** Dictionary of SELinux Flags|
|`haproxy_selinux_policy`|"default"|SELinux Policy to enforce|
|`haproxy_selinux_state`|"permissive"|SELinux State|

The SELinux Packages for the RedHat OS Family are overwritten in `vars/RedHat.yml`.

### Firewalld

:warning: If you want to use FirewallD Settings, this Role assumes, that you already habe FirewallD installed and enabled on the System. For more complicated Setups I would suggest using a dedicated Role.

These Variables give you some limited control over Firewalld Settings:

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_firewalld_enabled`|false|Lets you enable Firewalld Support|
|`haproxy_firewalld_ports`|[]|Lists of Ports to be enabled in Firewalld Settings|

### Sysctl

:warning: For more complicated Setups I would suggest using a dedicated Role.

You can set Sysctl Settings with these Variables:

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_sysctl_enabled`|false|Lets you enable Sysctl Support|
|`haproxy_sysctl_settings`|[]|List of Sysctl Settings|

Here is an Example on how to enable IP-Forwarding for IPv4:

```yaml
haproxy_sysctl_enabled: true
haproxy_sysctl_settings:
  - name: "net.ipv4.ip_forward"
    value: "1"
    sysctl_set: true
```

### Helper Scripts

If enabled with `haproxy_helper_scripts_enabled: true` this Role will add two Helper Scripts for you:

|Name|Description|
|:--|:--|
|`{{ haproxy_helper_scripts_dir }}/haproxy_status.sh`|Outputs a Status of the HAProxy (using the Prometheus Exporter)|
|`{{ haproxy_helper_scripts_dir }}/haproxy_nurse.sh`|Experimental: Self-Healing Script for ultra hight usage Scenarios to keep Memory usage at bay|

These Variables let you configure the Behaviour of the Helper Scripts:

|Name|Default|Decription|
|:--|:--|:--|
|`haproxy_helper_scripts_dir`|"/opt/haproxy"|Path where the Helper Scripts live|
|`haproxy_helper_scripts_metrics_auth`|""|Basic Auth Credentials for the Prometheus Exporter in the Format `-u prometheus:foobar`|
|`haproxy_helper_scripts_free_sys_mem`|1024|Memory in MegaBytes that should be free on the System|
|`haproxy_helper_scripts_max_idle_time`|300|Amount of Seconds with no Log events after that we declare HAProxy unresponsive|

:warning: For the `haproxy_nurse.sh` Script to work, rsyslog will be installed, to ensure that `{{ haproxy_log_file }}` exists and is written to instead of journald. Maybe you have to restart the System in certain conditions in order for the Log to appear.

## Docker Mode

In Docker Mode this role assumes:
- ... that you already have `docker` installed. This Role does not cover the Installation of the Docker Runtime.
- ... that you have the Docker-Compose-Plugin installed, if you want to run the Container on a Host
  - We use the [V2](https://docs.docker.com/compose/) Compose Version.

You may just Build and Push the created Image into a Docker Repository for use in different Scenarios like Kubernetes.

:warning: Set or overwrite the Variable `haproxy_mode` to `"docker"` if you want to use this Mode.

### Supported Versions

This Role is tested for all [Versions](https://endoflife.date/haproxy) from 2.5.0 (23 Nov 2021 EOL) to 2.9.5 (15 Feb 2024). For Production use you should stick to the latest Stable Version.

This Variable sets the Version for HAProxy inside the Docker Image:

|Name|Default|Description|
|:--|:--|:--|
|`haproxy_docker_patch_version`|2.8.6|This **must** be an exact [SemVer](https://semver.org/) Version.|
|`haproxy_docker_src_download_url`|""|Provide the Exact URL to a tar.gz to overwrite the default Download URL. You still have to set `haproxy_docker_patch_version` to a SemVer Version.|

By Default all Sources are Downloaded from [https://www.haproxy.org](https://www.haproxy.org/download/) and more specific from `https://www.haproxy.org/download/{{ haproxy_docker_patch_version.split('.')[0] }}.{{ haproxy_docker_patch_version.split('.')[1] }}/src/haproxy-{{ haproxy_docker_patch_version }}.tar.gz`

### Building, Naming, Tagging and Pushing of the Image

You can use this Role to build and push a customized Docker Image that is a little different than the [Official Images](https://hub.docker.com/_/haproxy/). The little Difference is the not needed docker-entrypoint.sh Script.

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_docker_build`|true|Build the Docker Image|
|`haproxy_docker_push`|false|Push the Docker Image, only works together with Building|
|`haproxy_docker_name`|"haproxy"|The Basename of the Image that will be build. If you plan to push it, [prefix it with your Docker Registry Address](https://docs.docker.com/engine/reference/commandline/image_push/#push-a-new-image-to-a-registry)|
|`haproxy_docker_image`|`"{{ haproxy_docker_name }}:{{ haproxy_docker_patch_version }}"`|You should not overwrite this directly, if you plan to Build and/or Push. Only when you want to run an other Image.|

These are the possible Customizations:

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_docker_base_image`|"debian:bookworm-slim"|The Base Image of the Container, if you change this you are on your own.|
|`haproxy_docker_config_dir`|"/etc/haproxy"|The Configuration Folder for HAProxy inside the Docker Container.|
|`haproxy_docker_user`|"haproxy"|The User and Group inside the Container.|
|`haproxy_docker_uid_gid`|99|The GID and UID for that User.|
|`haproxy_docker_workdir`|"/var/lib/haproxy"|The Workdir and Homedir of the User in the Container, changing this is not supported and comes with Implications.|
|`haproxy_docker_makeopts`|TARGET=linux-glibc<br>USE_GETADDRINFO=1<br>USE_LUA=1<br>LUA_INC=/usr/include/lua5.3<br>USE_OPENSSL=1<br>USE_PCRE2=1<br>USE_PCRE2_JIT=1<br>USE_PROMEX=1<br>EXTRA_OBJS=""|Make Options for HAProxy, if you change these you are on your own.|
|`haproxy_docker_commands`|"-W",<br>"-db",<br>"-f",<br>"{{ haproxy_docker_config_dir }}/{{ haproxy_config_file }}"|The build in HAProxy Start Command, if you change these you are on your own.|

### Running the Image localy

You can Run the Image localy with the Support of the `docker-compose-plugin` like this:

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_docker_compose`|false|If Enabled the Service will be started|
|`haproxy_docker_container_name`|"haproxy"|The Name of the started Docker Container|
|`haproxy_docker_mounts`|[source: "{{ haproxy_docker_dir }}/config",<br>target: "{{ haproxy_docker_config_dir }}",<br>type: "bind"]|How the Configuration is mounted into the Container.|
|`haproxy_docker_restart_policy`|"always"|You should keep this at [always or unless-stopped](https://github.com/compose-spec/compose-spec/blob/master/spec.md#restart) to have the Service start after Reboot.|
|`haproxy_docker_sysctls`|["net.ipv4.ip_unprivileged_port_start=0"]|You should keep this if you want HAProxy to serve Ports below 1024, if you add more you are on your own.|
|`haproxy_docker_log_options`|[driver: "json-file", options: [max-size: "10m", max-file: "1"]]|We do not want Docker to fill our Drives with Logs.|
|`haproxy_docker_extra_ports`|[]|Add a List of extra Ports in the Format `"<host_port>:<container_port>"` that are not in haproxy_frontend_vars or haproxy_listener_vars (added automaticaly).|
|`haproxy_docker_cpu_count`|"1"|The Containers [cpus_count](https://docs.docker.com/compose/compose-file/05-services/#cpu_count) Setting.|
|`haproxy_docker_memory_reservation`|"0.5g"|The Containers [--memory-reservation](https://docs.docker.com/config/containers/resource_constraints/#limit-a-containers-access-to-memory) Setting.|
|`haproxy_docker_memory`|"1g"|The Containers [--memory](https://docs.docker.com/config/containers/resource_constraints/#limit-a-containers-access-to-memory) Setting.|
|`haproxy_docker_service_extra_settings`|[]|A List of [services top-level variables](https://docs.docker.com/compose/compose-file/05-services/) not set in other settings above. In the Format `<setting>: <value>`|

You can find required CPU and memory Settings for your Setup [here](https://www.haproxy.com/documentation/haproxy-enterprise/getting-started/installation/linux/). You should always set Limitations for your Containers, because they can [impact the Host](https://docs.docker.com/config/containers/resource_constraints/).

If you want to Reload the Haproxy inside the Container execute this command: `docker kill -s USR2 {{ haproxy_docker_container_name }}`. Very usefull after renewing TLS Certificates. On Configuration Change this Role also does this in the "Reload Docker Haproxy" Handler.

### Run a prebuild Image

If you plan to use the [Official Image](https://hub.docker.com/_/haproxy/) or any other prebuild Image, you should tinker with these Variables:

|Name|Default|Description|
|:--|:--|:--|
|`haproxy_docker_image`|`"{{ haproxy_docker_name }}:{{ haproxy_docker_patch_version }}"`|Set this to the full Path of your Image|
|`haproxy_docker_mounts`|`[source: "{{ haproxy_docker_dir }}/config", target: "{{ haproxy_docker_config_dir }}", type: "bind"]`|Here you can configure your Docker Mounts|

Look at the [Playbook Docker official Image](#playbook-docker-official-image) Section for an Example on how to do this.

# Haproxy Configuration

The Configuration Sections are separated into different Variables.

|Section|Variable|Type|Template|
|:--|:--|:--|:--|
|[global](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3)|`haproxy_global_vars`|List|`templates/haproxy_global.j2`|
|[defaults](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#4)|`haproxy_defaults_vars`|List|`templates/haproxy_defaults.j2`|
|[userlist](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3.4)|`haproxy_userlist_vars`|List of name and vars|`templates/haproxy_userlist.j2`|
|[peers](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3.5)|`haproxy_peers_vars`|List of name and vars|`templates/haproxy_peers.j2`|
|[mailers](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3.6)|`haproxy_mailsers_vars`|List of name and vars|`templates/haproxy_mailers.j2`|
|[programs](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3.7)|`haproxy_programs_vars`|List of name and vars|`templates/haproxy_programs.j2`|
|[http-errors](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3.8)|`haproxy_httperrors_vars`|List of name and vars|`templates/haproxy_httperrors.j2`|
|[rings](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3.9)|`haproxy_rings_vars`|List of name and vars|`templates/haproxy_rings.j2`|
|[log-forward](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3.10)|`haproxy_logforward_vars`|List of name and vars|`templates/haproxy_logforward.j2`|
|[modules](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3.11)|`haproxy_modules_vars`|List|`templates/haproxy_modules.j2`|
|[resolvers](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#5.3.2)|`haproxy_resolvers_vars`|List of name and vars|`templates/haproxy_resolvers.j2`|
|[listen](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#4)|`haproxy_listen_vars`|List of name and vars|`templates/haproxy_listen.j2`|
|[frontend](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#4)|`haproxy_frontend_vars`|List of name and vars|`templates/haproxy_frontend.j2`|
|[backend](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#4)|`haproxy_backend_vars`|List of name and vars|`templates/haproxy_backend.j2`|

The `templates/haproxy_modules.j2` Template is a **generic** Template that you could use to create any section you want.

## Default Configuration

```yaml
haproxy_global_vars:
  - "log /dev/log local0"
  - "log /dev/log local1 notice"
  - "chroot /var/lib/haproxy"
  - "user haproxy"
  - "group haproxy"
  - "daemon"
haproxy_defaults_vars:
  - "option tcplog"
  - "log global"
  - "option dontlognull"
  - "timeout connect 5000"
  - "timeout client 500000"
  - "timeout server 500000"
  - "errorfiles default_error_files"
haproxy_userlist_vars: []
haproxy_peers_vars: []
haproxy_mailers_vars: []
haproxy_programs_vars: []
haproxy_httperrors_vars:
  - name: "default_error_files"
    vars:
      - "errorfile 400 /etc/haproxy/errors/400.http"
      - "errorfile 403 /etc/haproxy/errors/403.http"
      - "errorfile 408 /etc/haproxy/errors/408.http"
      - "errorfile 500 /etc/haproxy/errors/500.http"
      - "errorfile 502 /etc/haproxy/errors/502.http"
      - "errorfile 503 /etc/haproxy/errors/503.http"
      - "errorfile 504 /etc/haproxy/errors/504.http"
haproxy_rings_vars: []
haproxy_logforward_vars: []
haproxy_modules_vars: []
haproxy_resolvers_vars: []
haproxy_listen_vars: []
haproxy_frontend_vars:
  - name: "prometheus"
    vars:
      - "mode http"
      - "bind localhost:{{ haproxy_prometheus_port }}"
      - "http-request use-service prometheus-exporter if { path /metrics }"
      - "stats enable"
      - "stats uri /stats"
      - "stats refresh 10s"
haproxy_backend_vars: []
```

This will produce this valid haproxy.cfg:

```
# Ansible managed: Do NOT edit this file manually!
global
  log /dev/log local0
  log /dev/log local1 notice
  chroot /var/lib/haproxy
  user haproxy
  group haproxy
  daemon

defaults
  option tcplog
  log global
  mode tcp
  option dontlognull
  timeout connect 5000
  timeout client 500000
  timeout server 500000
  errorfiles default_error_files

http-errors default_error_files
  errorfile 400 /etc/haproxy/errors/400.http
  errorfile 403 /etc/haproxy/errors/403.http
  errorfile 408 /etc/haproxy/errors/408.http
  errorfile 500 /etc/haproxy/errors/500.http
  errorfile 502 /etc/haproxy/errors/502.http
  errorfile 503 /etc/haproxy/errors/503.http
  errorfile 504 /etc/haproxy/errors/504.http

frontend prometheus
  mode http
  bind localhost:8404
  http-request use-service prometheus-exporter if { path /metrics }
  stats enable
  stats uri /stats
  stats refresh 10s
```

A full Configuration Example can be found in `test/haproxy_full.yml`

## TLS Certificates

This Role wants you to have the Creation and Management of your TLS Certificates in a seperate Role.

The Certificates (or Symlinkt to them) should be present in the `/etc/haproxy/certs` directory in the [PEM combined Format](https://www.haproxy.com/documentation/haproxy-configuration-tutorials/ssl-tls/#tls-between-the-load-balancer-and-clients) that HAProxy understands. They should be imported in your HTTPS Frontend (as a directory) like this:

```yaml
haproxy_global_vars:
  - "ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305"
  - "ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
  - "ssl-default-bind-options prefer-client-ciphers no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets"
  - "ssl-default-server-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305"
  - "ssl-default-server-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
  - "ssl-default-server-options no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets"
  - "ssl-dh-param-file {{ haproxy_config_dir }}/dhparams.pem"
  ...
haproxy_frontend_vars:
  - name: "http"
    vars:
      - "mode http"
      - "bind *:443 ssl crt /etc/haproxy/certs/ alpn h2,http/1.1"
      - "http-request set-header X-Real-IP %[src]"
      - "http-request set-header X-Forwarded-Host %[req.hdr(host)]"
      - "http-request set-header X-Forwarded-Port %[dst_port]"
      - "http-request set-header X-Forwarded-For %[src]"
      - "http-request set-header X-Forwarded-Proto https"
      - "http-response set-header Strict-Transport-Security max-age=63072000"
  ...
```

Look at the [TLS Configuration Generator](https://ssl-config.mozilla.org/#server=haproxy&version=2.8) from Mozilla to find suitable Options for you.

In order to help with the Integration of TLS Certificates, this Role has some Switches:

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_dhparams_create`|false|Create a dhparams.pem File for you.|
|`haproxy_dhparams_speedup`|false|Install [haveged](https://github.com/jirka-h/haveged) for Kernels older than 5.6 to speed up Entropy Generation.|
|`haproxy_dhparams_bits`|2048|The Size of the Diffie-Hellman Parameters for the dhparams File.|
|`haproxy_dhparams_file`|`"{{ haproxy_config_dir }}/dhparams.pem"`|Full Path where to store the dhparams.pem File.|

Usualy it is completely sufficient to reload Haproxy via `systemctl reload haproxy.service` in order for all new Connections to get new Certificates.

There is a Solution on how to [integrate acme.sh](https://www.haproxy.com/blog/haproxy-and-let-s-encrypt) to work with HAProxy. Here the Admin Socket is used to put the Certificates directly into HAProxy's memory during execution.

## Logging

Normaly the HAPhroxy Package includes a file `/etc/logrotate.d/haproxy`, that rotates the file `/var/log/haproxy.log`. This Logfile is written to via the RSyslog Settings in `/etc/rsyslog.d/49-haproxy.conf` and works from the more secure [chrooted Environment](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3.1-chroot) too.

Idealy you just have to keep the default **global** Settings. Alternatively you should include these Settings in your individual `haproxy_global_vars` for Logging to work:

```yaml
haproxy_global_vars:
  - "log /dev/log local0"
  - "log /dev/log local1 notice"
  - "chroot /var/lib/haproxy"
  - "user haproxy"
  - "group haproxy"
  - "daemon"
  ...
```

You can fiddle with the Location of the Logfile by using these Settings:

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_config_logrotate`|false|Enables individual Logrotation Config.|
|`haproxy_log_file`|"/var/log/haproxy.log"|The Logfile Location.|

You may individualize the default Log Formats as described in the [Documentation](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#8.2) in your **global** Configuration Section.

More Informations about [Configuring Haproxy Logging](https://sematext.com/blog/haproxy-logs/).

If you are running haproxy as the Entrypoint of a Docker Container, you want to log directly to stdout like this:

```
haproxy_global_vars:
  - "log stdout format raw daemon info"
  ...
```

## Secrets

You may want to Encrypt certain sensitive Informations in your Playbook/Inventory Variables.

For this you have to create a Secret variable like this:

```yaml
haproxy_example_secret: !vault |
  $ANSIBLE_VAULT;1.1;AES256
  64336533393735353032633233653937313761343464626365346535303938376230316339663465
  6631613937613534353663363035313034613537656634620a356563396136333936373466633761
  65373639623164613930316131323638343334316238323335656666373434363762376332343564
  3731396431396438380a633932383466656139313163633164313632353635616131663166313562
  3039
```

You get this Secret by Invoking the `ansible-vault` Tool that comes by Default with Ansible like this:

```shell
# To store your Vault Key in a File
echo "sup3rs3cr3t_not" > .ansible-vault
# For BasicAuth Credentials
echo -n "foo:bar" | base64 | ansible-vault encrypt --vault-password-file .ansible-vault
# For Plain Secrets
echo -n "foobar" | ansible-vault encrypt --vault-password-file .ansible-vault
```

Then use the Variable in one of your Configuration Settings like this (Yes, the Variables are filled in when used, this works fine):

```yaml
haproxy_backend_vars:
  - name: "be_api"
    vars:
      - "mode http"
      - "server be_api 127.0.0.1:8081"
      - "option httpchk GET /path_to_heath_check HTTP/1.1\r\nAuthorization:\ Basic\ {{ haproxy_example_secret }}"
haproxy_userlist_vars:
  - name: "myusers"
    vars:
      - "user joe insecure-password {{ haproxy_example_secret }}"
```

You have to provide the `.ansible-vault` File used in this example to the ansible-playbook Command like this:

```shell
ansible-playbook --vault-pass-file .ansible-vault -i your_inventory.yml your_playbook.yml
```

There are other good methods of providing a [Vault Key for Ansible](https://docs.ansible.com/ansible/latest/vault_guide/index.html).

:warning: You should never push your Vault Key into a git Repository (they never forget). Because of this `.ansible-vault` is included in the `.gitignore` File and you should do the same if you consider using a different Filename.

## Metrics

By Default this Role comes with the [Prometheus Metrics Plugin](https://www.haproxy.com/blog/haproxy-exposes-a-prometheus-metrics-endpoint) enabled on the localhost Port **8404** as defined in the `haproxy_prometheus_port` Variable.

It is configured in the Default prometheus Frontend:

```yaml
haproxy_frontend_vars:
  - name: "prometheus"
    vars:
      - "mode http"
      - "bind localhost:{{ haproxy_prometheus_port }}"
      - "http-request use-service prometheus-exporter if { path /metrics }"
      - "stats enable"
      - "stats uri /stats"
      - "stats refresh 10s"
```

This Endpoint is used in the `{{ haproxy_helper_scripts_dir }}/haproxy_status.sh` Helper Script to Query the Metrics with curl:

```shell
curl --silent {{ haproxy_helper_scripts_metrics_auth }} localhost:{{ haproxy_prometheus_port }}/metrics
```

If you want to expose the Metrics Endpoint to a Network, it is a good Idea to use BasicAuth to secure it:

```yaml
haproxy_frontend_vars:
  - name: "prometheus"
    vars:
      - "mode http"
      - "bind *:{{ haproxy_prometheus_port }}"
      - "stats enable"
      - "stats uri /stats"
      - "stats refresh 10s"
      - "http-request auth unless { http_auth(mycredentials) }"
      - "acl metrics_path path /metrics"
      - "http-request use-service prometheus-exporter if { path /metrics }"
haproxy_userlist_vars:
  - name: "mycredentials"
    vars:
      - "user prometheus insecure-password {{ haproxy_prometheus_password }}"
```

You have to create the Variable `haproxy_prometheus_password` on your own as described in the [Secrets](#secrets) Section.

If you use the `haproxy_status.sh` Script, you want to encode a matching `haproxy_helper_scripts_metrics_auth` Variable too.

Then you are able to Scrape the Metrics with [Prometheus](https://prometheus.io/) like this:

```yaml
scrape_configs:
  - job_name: haproxy
    static_configs:
        - targets: ['your_haproxy_ip:{{ haproxy_prometheus_port }}']
    metrics_path: "/metrics"
    basic_auth:
      username: 'prometheus'
      password: '{{ haproxy_prometheus_password }}'
...
```

:warning: Make sure not to expose the HAProxy Metrics to the Internet unsecured, as they can be used to attack your Loadbalancer. Secure the Port behind a Firewall and use at least BasicAuth.

If you have [Grafana](https://grafana.com/) you may want to use [Dashboard 12693](https://grafana.com/grafana/dashboards/12693-haproxy-2-full/) to get the most out of the Prometheus Metrics.

## Error Files

HAProxy supports [Error Files](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#3.8) that are pre rendered HTTP responses:

```html
HTTP/1.1 400 Bad Request
Cache-Control: no-cache
Connection: close
Content-Type: text/html

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>400 Bad Request</title>
  </head>
  <body>
    <h1>400 Bad Request</h1>
    <h3>You sent a malformed Request.</h3>
  </body>
</html>
```

The Option [errorfile](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#4-errorfile) can be defined in all proxy Sections (**defaults**, **frontend**, **listen** and **backend**) of the Configuration. Groups of Error Files can be defined in the **http-errors** section for later use with the [errorfiles](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#4.2-errorfiles) option.

These are the Default Errorpages:

```yaml
haproxy_error_files:
  - state: 400
    description: "Bad Request"
    explanation: "You sent a malformed Request."
    method: "close"
  - state: 403
    description: "Forbidden"
    explanation: "You do not have Access to this Site."
    method: "close"
  - state: 408
    description: "Request Timeout"
    explanation: "Your Request timed out."
    method: "close"
  - state: 500
    description: "Internal Server Error"
    explanation: "There is an internal Server Error on our side."
    method: "close"
  - state: 502
    description: "Bad Gateway"
    explanation: "The Server could not redirect you."
    method: "close"
  - state: 503
    description: "Service Unavailable"
    explanation: "This Service is currently unavailable."
    method: "close"
  - state: 504
    description: "Gateway Timeout"
    explanation: "The Server could not redirect you in time."
    method: "close"
```

They are rendered with this Default Template `templates/errorfile.http.j2`:

```jinja
HTTP/1.1 {{ item.state }} {{ item.description }}
Cache-Control: no-cache
Connection: {{ item.method }}
Content-Type: text/html

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>{{ item.state }} {{ item.description }}</title>
  </head>
  <body>
     <h1>{{ item.state }} {{ item.description }}</h1>
     <h3>{{ item.explanation }}</h3>
  </body>
</html>
```

All Error Files will be created in the Subdirectory **errors/** of the Config Directory having the Name `{{ item.state }}.http`. By Default there is a **http-errors** Section in the Configuration that will be used in the **default** Section for all Proxy Sections.

Since Error Pages are [highly customizable](https://www.haproxy.com/blog/serve-dynamic-custom-error-pages-with-haproxy) please feel free to modify the Template and the `haproxy_error_files` and `haproxy_httperrors_vars` Variables according to your needs.

## Configmaps

HAProxy supports [Configuration Maps](https://www.haproxy.com/documentation/haproxy-configuration-manual/latest/#7.3.1-map) that are Key Value Pairs seperated by a whitespace:

```
example.com           be_default
api.example.com       be_api
```

You may use them in ACL's and other Configuration Settings:

```yaml
haproxy_frontend_vars:
  - name: "default"
    vars:
      - "mode http"
      - "bind :80"
      - "use_backend %[req.hdr(host),lower,map_dom(/etc/haproxy/maps/hosts.map,be_default)]"
haproxy_backend_vars:
  - name: "be_default"
    vars:
      - "mode http"
      - "server be_default 127.0.0.1:8080"
  - name: "be_api"
    vars:
      - "mode http"
      - "server be_api 127.0.0.1:8081"
```

You can define such maps in the `haproxy_configmaps` Variable:

```yaml
haproxy_config_maps:
  - hosts:
      example.com: "be_default"
      api.example.com: "be_api"
```

All Configmaps will be created in the Subdirectory **maps/** of the Config Directory having the File Ending `.map`

## LUA Files

You can [extend the functioanlity of HAProxy](https://www.haproxy.com/blog/5-ways-to-extend-haproxy-with-lua) with the use of [LUA](https://www.lua.org/) Scripts.

You have to put your **.lua** Files into the `files/lua/` Directory and include the Filename in the `haproxy_lua_files` List. Then modify the Configuration to load and use them.

Enable the Use of LUA Files by using these Variables:

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_lua_dir`|`"{{ haproxy_config_dir }}/lua"`|The Path where the LUA Files should be stored.|
|`haproxy_lua_files`|[]|A List of files that should be copied into the `haproxy_lua_dir`.|

All LUA Files will be created in the Subdirectory **lua/** of the Config Directory.

# Role Steering Variables

|Name|Optional|Mode|Default|Description|
|:--|:--|:--|:--|:--|
|`haproxy_mode`|false|both|"system"|Can be one of `system` or `docker`|
|`haproxy_helper_scripts_enabled`|true|both|false|Install the Helper Scipts|
|`haproxy_dhparams_create`|true|both|false|Create a dhparams File|
|`haproxy_dhparams_speedup`|true|both|false|Speedup Entropy Generation on older Kernels|
|`haproxy_config_file`|true|both|"haproxy.cfg"|The Name of the Haproxy Configuration|
|`haproxy_docker_build`|true|docker|false|Select if you want to build a Docker Image|
|`haproxy_docker_push`|true|docker|false|Select if you want to push the Image to a Registry|
|`haproxy_docker_compose`|true|docker|false|Select if you want to run the Image with Docker Compose|
|`haproxy_service_state`|true|system|"started"|The Condition the HAProxy should be set to|
|`haproxy_config_logrotate`|true|system|false|Select if you want to change the Logging to rsyslogd and Configure Logortation|
|`haproxy_selinux_enabled`|true|system|false|Select if you want to configure SELinux Settings|
|`haproxy_firewalld_enabled`|true|system|false|Select if you want to configure FirewallD Settings|
|`haproxy_sysctl_enabled`|true|system|false|Seclect if you want to configure Kernel Parameters|
|`haproxy_show_debug`|true|system|false|If you enable this some Debug Information is shown|
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

# Example Playbooks

To use this Role install it from the Ansible Galaxy

Eighter from Shell on your local machine:

```shell
ansible-galaxy role install micimo.haproxy
```

Or put it into a `requirements.yml` that can be installed with `ansible-galaxy install -r requirements.yml`

```yaml
roles:
  - name: micimo.haproxy
```

For all Requirements for this Project look at the [requirements.yml](requirements.yml)

## Playbook System Simple

This will set up:
- A HAProxy Service will be installed on the System (managed by Systemd) with the Default Version for that System.
- A Prometheus Frontend for Metrics on the default Port 8404.
- A HTTP Frontend listening on Port 80, forwarding Traffic to the web_servers Backends.
- Three Backends in leastconn Balancing Mode.
- A Port Forward from 8080 to an SSH Port (22) on remote_backend in TCP Mode. Be extra carefull with something like this.

```yaml
---
- name: Simple Haproxy Setup.
  hosts: debian-bookworm
  gather_facts: true
  become: true
  roles:
    - role: micimo.haproxy
  vars:
    haproxy_mode: "system"
    haproxy_frontend_vars:
      - name: "prometheus"
        vars:
          - "mode http"
          - "bind localhost:{{ haproxy_prometheus_port }}"
          - "http-request use-service prometheus-exporter if { path /metrics }"
          - "stats enable"
          - "stats uri /stats"
          - "stats refresh 10s"
      - name: "http"
        vars:
          - "mode http"
          - "bind *:80"
          - "default_backend web_servers"
    haproxy_backend_vars:
      - name: "web_servers"
        vars:
          - "mode http"
          - "balance leastconn"
          - "server myfirstserver 192.168.1.25:80 check"
          - "server mysecondserver 192.168.1.26:80 check"
          - "server mythirdserver 192.168.1.27:80 check"
    haproxy_listen_vars:
      - name: "ssh_proxy"
        vars:
          - "mode tcp"
          - "bind *:8080"
          - "server server1 192.168.1.25:22 check"  
```

## Playbook System Advanced

This will set up:
- A HAProxy Service on the System (managed by Systemd) with the supported Version for that System.
- An exposed Prometheus Frontend for Metrics with Basic Authentication on port 9404.
- Two subdomain Configmaps to redirect different Subdomains to various Backends.
- A HTTP Frontend, that will redirect to various Backends using a Configmap.
- A HTTPS Frontend with TLS Termination, that will redirect to various Backends using a different Configmap.
- A pre generated dhparams File for the TLS Handshakes.
- It will install the Helper Scripts with the Correct `haproxy_helper_scripts_metrics_auth` in the `haproxy_status.sh`.

```yaml
---
- name: Advanced Haproxy Setup.
  hosts: debian_bookworm
  gather_facts: true
  become: true
  roles:
    - role: micimo.haproxy
  vars:
    haproxy_mode: "system"
    haproxy_version: "2.6"
    haproxy_dhparams_create: true
    haproxy_prometheus_port: 9404
    haproxy_helper_scripts_enabled: true
    # Vaulted String "-u prometheus:foobar"
    haproxy_helper_scripts_metrics_auth: !vault |
      $ANSIBLE_VAULT;1.1;AES256
      33346434653732636364643334303839633432396634323261643463303737343239636431663032
      3738303165623032353936373064383631393733366164390a366566303932303436373563303933
      30313735363137643735353632383631383038346239383236646132336537666362346462333036
      3236646434653435370a313934626231303664623837393664623064356365326361356535306434
      34336464346566356332396239373866313763663162626237313265313363643438
    # Vaulted String "foobar"
    haproxy_prometheus_secret: !vault |
      $ANSIBLE_VAULT;1.1;AES256
      64336533393735353032633233653937313761343464626365346535303938376230316339663465
      6631613937613534353663363035313034613537656634620a356563396136333936373466633761
      65373639623164613930316131323638343334316238323335656666373434363762376332343564
      3731396431396438380a633932383466656139313163633164313632353635616131663166313562
      3039
    haproxy_global_vars:
      - "log /dev/log local0"
      - "log /dev/log local1 debug"
      - "chroot /var/lib/haproxy"
      - "user haproxy"
      - "group haproxy"
      - "daemon"
      - "ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305"
      - "ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
      - "ssl-default-bind-options prefer-client-ciphers no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets"
      - "ssl-default-server-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305"
      - "ssl-default-server-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
      - "ssl-default-server-options no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets"
      - "ssl-dh-param-file {{ haproxy_config_dir }}/dhparams.pem"
    haproxy_userlist_vars:
      - name: "mycredentials"
        vars:
          - "user prometheus insecure-password {{ haproxy_prometheus_secret }}"
    haproxy_config_maps:
      - http_hosts:
          example.com: "be_default_http"
          api.example.com: "be_api_http"
      - https_hosts:
          example.com: "be_default_https"
          api.example.com: "be_api_https"
    haproxy_frontend_vars:
      - name: "prometheus"
        vars:
          - "mode http"
          - "bind *:{{ haproxy_prometheus_port }}"
          - "stats enable"
          - "stats uri /stats"
          - "stats refresh 10s"
          - "http-request auth unless { http_auth(mycredentials) }"
          - "acl metrics_path path /metrics"
          - "http-request use-service prometheus-exporter if { path /metrics }"
      - name: "http"
        vars:
          - "mode http"
          - "bind *:80"
          - "use_backend %[req.hdr(host),lower,map({{ haproxy_maps_dir }}/http_hosts.map,be_default_http)]"
      - name: "https"
        vars:
          - "mode http"
          - "bind *:443 ssl crt {{ haproxy_certs_dir }}/ alpn h2,http/1.1"
          - "http-request set-header X-Real-IP %[src]"
          - "http-request set-header X-Forwarded-Host %[req.hdr(host)]"
          - "http-request set-header X-Forwarded-Port %[dst_port]"
          - "http-request set-header X-Forwarded-For %[src]"
          - "http-request set-header X-Forwarded-Proto https"
          - "http-response set-header Strict-Transport-Security max-age=63072000"
          - "use_backend %[req.hdr(host),lower,map({{ haproxy_maps_dir }}/https_hosts.map,be_default_https)]"
    haproxy_backend_vars:
      - name: "be_default_http"
        vars:
          - "mode http"
          - "server myfirstserver 127.0.0.1:8080 check"
      - name: "be_api_http"
        vars:
          - "mode http"
          - "server mysecondserver 127.0.0.1:8080 check"
      - name: "be_default_https"
        vars:
          - "mode http"
          - "server myfirstserver 127.0.0.1:8443 check"
      - name: "be_api_https"
        vars:
          - "mode http"
          - "server mysecondserver 127.0.0.1:8443 check"
...
```

## Playbook Docker Compose

This will set up:
- A Docker Image with the Default Version
- A running Docker Container managed by the Compose Plugin.
- The exact same Configuration as the [Playbook System Simple](#playbook-system-simple) Example.
- We have to overwrite the default `haproxy_validation_command`, because we can not verify the Config without a local HAProxy.
- :warning: Be extra carefull with the exposed unsecured Prometheus Metrics Port 8404 here

```yaml
---
- name: Docker Compose Haproxy Setup.
  hosts: local
  gather_facts: true
  become: true
  roles:
    - role: micimo.haproxy
  vars:
    haproxy_mode: "docker"
    haproxy_docker_build: true
    haproxy_docker_compose: true
    haproxy_helper_scripts_enabled: true
    haproxy_validation_command: "/bin/true %s"
    haproxy_global_vars:
      - "log stdout local0 debug"
    haproxy_frontend_vars:
      - name: "prometheus"
        vars:
          - "mode http"
          - "bind *:{{ haproxy_prometheus_port }}"
          - "http-request use-service prometheus-exporter if { path /metrics }"
          - "stats enable"
          - "stats uri /stats"
          - "stats refresh 10s"
      - name: "http"
        vars:
          - "mode http"
          - "bind *:80"
          - "default_backend web_servers"
    haproxy_backend_vars:
      - name: "web_servers"
        vars:
          - "mode http"
          - "balance leastconn"
          - "server myfirstserver 192.168.1.25:80 check"
          - "server mysecondserver 192.168.1.26:80 check"
          - "server mythirdserver 192.168.1.27:80 check"
    haproxy_listen_vars:
      - name: "ssh_proxy"
        vars:
          - "mode tcp"
          - "bind *:8080"
          - "server server1 192.168.1.25:22 check"
...
```

## Playbook Docker Push

This will set up:
- A Docker Image with a specific Version and Registry Path to push it to.
- The User in the Docker Image that will run the Haproxy is named `harharproxy` instead of the default `haproxy`
- The smalest Configuration possible that HAProxy accept as valid. Totaly useless, but valid.
- You must have a working [Docker Registry Authentification](https://docs.docker.com/reference/cli/docker/login/#examples) configured on the System for this to work.

```yaml
---
- name: Docker Compose Haproxy Setup.
  hosts: local
  gather_facts: true
  become: true
  roles:
    - role: micimo.haproxy
  vars:
    haproxy_mode: "docker"
    haproxy_docker_build: true
    haproxy_docker_name: "your-registry.domain.tld/docker/experiment:2.6.8"
    haproxy_docker_user: "harharproxy"
    haproxy_docker_push: true
    haproxy_frontend_vars:
      - name: "foo"
        vars:
          - "bind :9001"
          - "timeout client 5000"
    haproxy_global_vars: []
    haproxy_defaults_vars: []
    haproxy_httperrors_vars: []
    haproxy_error_files: []
...
```

## Playbook Docker official Image

This will set up:
- A Docker Compose File with the [official HAProxy Docker Image](https://hub.docker.com/_/haproxy/).
- The exact same Configuration as the [Playbook System Advanced](#playbook-system-advanced) Example.
- We have to overwrite the default `haproxy_docker_config_dir` and `haproxy_httperrors_vars`, because the official Image Entrypoint Script expects the Configuration in `/usr/local/etc/haproxy`.
- We have to overwrite the default `haproxy_validation_command`, because we can not verify the Config without a local HAProxy and the correct Paths.
- The Official Image is used, because `haproxy_docker_build` is false by default.

```yaml
---
- name: Official Docker Haproxy Setup.
  hosts: local
  gather_facts: true
  become: true
  roles:
    - role: micimo.haproxy
  vars:
    haproxy_mode: "docker"
    haproxy_docker_compose: true
    haproxy_version: "2.8.6"
    haproxy_testing_mode: true
    haproxy_docker_config_dir: "/usr/local/etc/haproxy"
    haproxy_validation_command: "/bin/true %s"
    haproxy_dhparams_create: true
    haproxy_prometheus_port: 9404
    haproxy_helper_scripts_enabled: true
    # Vaulted String "-u prometheus:foobar"
    haproxy_helper_scripts_metrics_auth: !vault |
      $ANSIBLE_VAULT;1.1;AES256
      33346434653732636364643334303839633432396634323261643463303737343239636431663032
      3738303165623032353936373064383631393733366164390a366566303932303436373563303933
      30313735363137643735353632383631383038346239383236646132336537666362346462333036
      3236646434653435370a313934626231303664623837393664623064356365326361356535306434
      34336464346566356332396239373866313763663162626237313265313363643438
    # Vaulted String "foobar"
    haproxy_prometheus_secret: !vault |
      $ANSIBLE_VAULT;1.1;AES256
      64336533393735353032633233653937313761343464626365346535303938376230316339663465
      6631613937613534353663363035313034613537656634620a356563396136333936373466633761
      65373639623164613930316131323638343334316238323335656666373434363762376332343564
      3731396431396438380a633932383466656139313163633164313632353635616131663166313562
      3039
    haproxy_global_vars:
      - "log stdout local0 debug"
      - "ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305"
      - "ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
      - "ssl-default-bind-options prefer-client-ciphers no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets"
      - "ssl-default-server-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305"
      - "ssl-default-server-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256"
      - "ssl-default-server-options no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets"
      - "ssl-dh-param-file {{ haproxy_docker_config_dir }}/dhparams.pem"
    haproxy_httperrors_vars:
      - name: "default_error_files"
        vars:
          - "errorfile 400 {{ haproxy_docker_config_dir }}/errors/400.http"
          - "errorfile 403 {{ haproxy_docker_config_dir }}/errors/403.http"
          - "errorfile 408 {{ haproxy_docker_config_dir }}/errors/408.http"
          - "errorfile 500 {{ haproxy_docker_config_dir }}/errors/500.http"
          - "errorfile 502 {{ haproxy_docker_config_dir }}/errors/502.http"
          - "errorfile 503 {{ haproxy_docker_config_dir }}/errors/503.http"
          - "errorfile 504 {{ haproxy_docker_config_dir }}/errors/504.http"
    haproxy_userlist_vars:
      - name: "mycredentials"
        vars:
          - "user prometheus insecure-password {{ haproxy_prometheus_secret }}"
    haproxy_config_maps:
      - http_hosts:
          example.com: "be_default_http"
          api.example.com: "be_api_http"
      - https_hosts:
          example.com: "be_default_https"
          api.example.com: "be_api_https"
    haproxy_frontend_vars:
      - name: "prometheus"
        vars:
          - "mode http"
          - "bind *:{{ haproxy_prometheus_port }}"
          - "stats enable"
          - "stats uri /stats"
          - "stats refresh 10s"
          - "http-request auth unless { http_auth(mycredentials) }"
          - "acl metrics_path path /metrics"
          - "http-request use-service prometheus-exporter if { path /metrics }"
      - name: "http"
        vars:
          - "mode http"
          - "bind *:80"
          - "use_backend %[req.hdr(host),lower,map({{ haproxy_docker_config_dir }}/maps/http_hosts.map,be_default_http)]"
      - name: "https"
        vars:
          - "mode http"
          - "bind *:443 ssl crt {{ haproxy_docker_config_dir }}/certs/ alpn h2,http/1.1"
          - "http-request set-header X-Real-IP %[src]"
          - "http-request set-header X-Forwarded-Host %[req.hdr(host)]"
          - "http-request set-header X-Forwarded-Port %[dst_port]"
          - "http-request set-header X-Forwarded-For %[src]"
          - "http-request set-header X-Forwarded-Proto https"
          - "http-response set-header Strict-Transport-Security max-age=63072000"
          - "use_backend %[req.hdr(host),lower,map({{ haproxy_docker_config_dir }}/maps/https_hosts.map,be_default_https)]"
    haproxy_backend_vars:
      - name: "be_default_http"
        vars:
          - "mode http"
          - "server myfirstserver 172.17.0.1:8080 check"
      - name: "be_api_http"
        vars:
          - "mode http"
          - "server mysecondserver 172.17.0.1:8080 check"
      - name: "be_default_https"
        vars:
          - "mode http"
          - "server myfirstserver 172.17.0.1:8443 check"
      - name: "be_api_https"
        vars:
          - "mode http"
          - "server mysecondserver 172.17.0.1:8443 check"
...
```

# Tipps and Tricks

- Find Proper TLS Certificate Settings in the [Moz://a SSL Configuration Generator](https://ssl-config.mozilla.org/)
- Test your TLS Configuration Strength with [Qualys SSL Labs](https://www.ssllabs.com/ssltest/)
- If you want to deploy a not functional haproxy.cfg overwrite the Variable `haproxy_validation_command` with "/bin/true %s". You also want to set `haproxy_service_state` or `haproxy_docker_compose` accordingly.
- Always make sure to only connect HTTP Mode Frontends to HTTP Mode Backends and only TCP Frontends to TCP Backends. I write the `mode` at the beginning of these Definitions and set it explicitly everywhere.
- Do not put your `dhparams.pem` File into a dynamically loaded certs Directory. HAProxy can currently not deal with that.

# License

This Work is licensed under the [GPLv3 License](https://www.gnu.org/licenses/gpl-3.0.de.html)

# Authors

Created in 2024 by [Martin Meier](https://micimo.de)
