# System Mode

In System Mode this Role assumes
- that the installation of the HAProxy package will create a HAProxy user (normally haproxy) that the process will run in.
  - You can modify the `haproxy_user` and `haproxy_group` variable if this is not the case.
  - This role does not cover the creation of this user.
- that the service on the system will be managed by Systemd.
- that you have SELinux set up already if you want to use it in this role.
- that you have Firewalld set up already if you want to use it in this role.

## Version Matrix

Look [here](https://haproxy.debian.net/) for Installation Instructions for Debian & Ubuntu Distributions. For RedHat Compatible Distributions, there are only the Default Versions at the Moment.

You can overwrite the Version with the `haproxy_version` Variable, but make sure that the `haproxy_versions` Variable in `defaults/main/versions.yml` also includes that Version on your Distribution.

If you want to modify the default Versions for multiple Distributions, you can do so with the `haproxy_<DISTRIBUTION>_<RELEASE>_default_version` Variables.

### Debian

|Version|End of Life|Debian 13 Trixie|Debian 12 Bookworm|Debian 11 Bullseye|
|:--|:--|:--|:--|:--|
|[3.3](http://git.haproxy.org/?p=haproxy-3.3.git)|2027-Q1|Supported|-|-|
|[3.2](http://git.haproxy.org/?p=haproxy-3.2.git)|2030-Q1 (LTS)|**Role Default** OS Default|**Role Default**|-|
|[3.1](http://git.haproxy.org/?p=haproxy-3.1.git)|2026-Q1|-|-|**Role Default**|
|[3.0](http://git.haproxy.org/?p=haproxy-3.0.git)|2029-Q2 (LTS)|Supported|Supported|Supported|
|[2.8](http://git.haproxy.org/?p=haproxy-2.8.git)|2028-Q2 (LTS)|-|Supported|Supported|
|[2.6](http://git.haproxy.org/?p=haproxy-2.6.git)|2027-Q2 (LTS)|-|OS Default|Supported|
|[2.2](http://git.haproxy.org/?p=haproxy-2.2.git)|2025-Q2 (critical fixes only)|-|-|OS Default|

### Ubuntu

|Version|End of Life|Ubuntu 24 Noble|Ubuntu 22 Jammy|Ubuntu 20 Focal|
|:--|:--|:--|:--|:--|
|[3.3](http://git.haproxy.org/?p=haproxy-3.3.git)|2027-Q1|Supported|-|-|
|[3.2](http://git.haproxy.org/?p=haproxy-3.2.git)|2030-Q1 (LTS)|**Role Default**|-|-|
|[3.0](http://git.haproxy.org/?p=haproxy.git)|2029-Q2 (LTS)|Supported|**Role Default**|**Role Default**|
|[2.8](http://git.haproxy.org/?p=haproxy-2.8.git)|2028-Q2 (LTS)|OS Default|Supported|Supported|
|[2.6](http://git.haproxy.org/?p=haproxy-2.6.git)|2027-Q2 (LTS)|-|Supported|Supported|Supported|
|[2.4](http://git.haproxy.org/?p=haproxy-2.4.git)|2026-Q2 (LTS)|-|OS Default|-|
|[2.0](http://git.haproxy.org/?p=haproxy-2.0.git)|2024-Q2 (critical fixes only)|-|-|OS Default|

### RockyLinux

|Version|End of Life|10.1 Red Quartz|9.7 Blue Onyx|
|:--|:--|:--|:--|
|[3.0](http://git.haproxy.org/?p=haproxy.git)|2029-Q2 (LTS)|OS Default|-|
|[2.8](http://git.haproxy.org/?p=haproxy-2.8.git)|2026-Q2 (LTS)|-|OS Default|

### AlmaLinux

|Version|End of Life|10.1 Heliotrope Lion|9.7 Moss Jungle Cat|
|:--|:--|:--|:--|
|[3.0](http://git.haproxy.org/?p=haproxy.git)|2029-Q2 (LTS)|OS Default|-|
|[2.8](http://git.haproxy.org/?p=haproxy-2.8.git)|2026-Q2 (LTS)|-|OS Default|

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

:warning: If you want to use Firewalld Settings, this Role assumes, that you already have Firewalld installed and enabled on the System. For more complicated Setups I would suggest using a dedicated Role.

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
|`{{ haproxy_helper_scripts_dir }}/haproxy_nurse.sh`|Experimental: Self-Healing Script for ultra high usage Scenarios to keep Memory usage at bay|

These Variables let you configure the Behaviour of the Helper Scripts:

|Name|Default|Description|
|:--|:--|:--|
|`haproxy_helper_scripts_dir`|"/opt/haproxy"|Path where the Helper Scripts live|
|`haproxy_helper_scripts_metrics_auth`|""|Basic Auth Credentials for the Prometheus Exporter in the Format `-u prometheus:foobar`|
|`haproxy_helper_scripts_free_sys_mem`|1024|Memory in Megabytes that should be free on the System|
|`haproxy_helper_scripts_max_idle_time`|300|Amount of Seconds with no Log events after that we declare HAProxy unresponsive|

:warning: For the `haproxy_nurse.sh` Script to work, rsyslog will be installed, to ensure that `{{ haproxy_log_file }}` exists and is written to instead of journald. Maybe you have to restart the System in certain conditions in order for the Log to appear.

