# Docker Mode

In Docker Mode this role assumes:
- that you already have `docker` installed. This Role does not cover the Installation of the Docker runtime.
- that you have the Docker-Compose-Plugin installed, if you want to run the Container on a Host
  - We use the [V2](https://docs.docker.com/compose/) Compose Version.

You may just Build and Push the created Image into a Docker Repository for use in different Scenarios like Kubernetes.

:warning: Set or overwrite the Variable `haproxy_mode` to `"docker"` if you want to use this Mode.

### Supported Versions

This Role is tested for all [Versions](https://endoflife.date/haproxy) from 2.5.0 (23 Nov 2021 EOL) to 3.2.3 (9 July 2025). For Production use you should stick to the latest Stable Version.

This Variable sets the Version for HAProxy inside the Docker Image:

|Name|Default|Description|
|:--|:--|:--|
|`haproxy_docker_patch_version`|3.2.3|This **must** be an exact [SemVer](https://semver.org/) Version.|
|`haproxy_docker_src_download_url`|""|Provide the Exact URL to a tar.gz to overwrite the default Download URL. You still have to set `haproxy_docker_patch_version` to a SemVer Version.|

By Default all Sources are Downloaded from [https://www.haproxy.org](https://www.haproxy.org/download/) and more specific from `https://www.haproxy.org/download/{{ haproxy_docker_patch_version.split('.')[0] }}.{{ haproxy_docker_patch_version.split('.')[1] }}/src/haproxy-{{ haproxy_docker_patch_version }}.tar.gz`

### Building, Naming, Tagging and Pushing of the Image

You can use this Role to build and push a customized Docker Image that is a little different than the [Official Images](https://hub.docker.com/_/haproxy/). The little Difference is the not needed docker-entrypoint.sh Script.

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_docker_build`|true|Build the Docker Image|
|`haproxy_docker_push`|false|Push the Docker Image, only works together with Building|
|`haproxy_docker_name`|"haproxy"|The Base name of the Image that will be build. If you plan to push it, [prefix it with your Docker Registry Address](https://docs.docker.com/engine/reference/commandline/image_push/#push-a-new-image-to-a-registry)|
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

### Running the Image locally

You can Run the Image locally with the Support of the `docker-compose-plugin` like this:

|Variable|Default|Description|
|:--|:--|:--|
|`haproxy_docker_compose`|false|If Enabled the Service will be started|
|`haproxy_docker_container_name`|"haproxy"|The Name of the started Docker Container|
|`haproxy_docker_mounts`|[source: "{{ haproxy_docker_dir }}/config",<br>target: "{{ haproxy_docker_config_dir }}",<br>type: "bind"]|How the Configuration is mounted into the Container.|
|`haproxy_docker_restart_policy`|"always"|You should keep this at [always or unless-stopped](https://github.com/compose-spec/compose-spec/blob/master/spec.md#restart) to have the Service start after Reboot.|
|`haproxy_docker_sysctls`|["net.ipv4.ip_unprivileged_port_start=0"]|You should keep this if you want HAProxy to serve Ports below 1024, if you add more you are on your own.|
|`haproxy_docker_log_options`|[driver: "json-file", options: [max-size: "10m", max-file: "1"]]|We do not want Docker to fill our Drives with Logs.|
|`haproxy_docker_extra_ports`|[]|Add a List of extra Ports in the Format `"<host_port>:<container_port>"` that are not in haproxy_frontend_vars or haproxy_listen_vars (added automatically).|
|`haproxy_docker_cpu_count`|"1"|The Containers [cpus_count](https://docs.docker.com/compose/compose-file/05-services/#cpu_count) Setting.|
|`haproxy_docker_mem_reservation`|"0.5g"|The Containers [--memory-reservation](https://docs.docker.com/config/containers/resource_constraints/#limit-a-containers-access-to-memory) Setting.|
|`haproxy_docker_mem_limit`|"1g"|The Containers [--memory](https://docs.docker.com/config/containers/resource_constraints/#limit-a-containers-access-to-memory) Setting.|
|`haproxy_docker_service_extra_settings`|[]|A List of [services top-level variables](https://docs.docker.com/compose/compose-file/05-services/) not set in other settings above. In the Format `<setting>: <value>`|
|`haproxy_docker_healthcheck`|['test: ["CMD", "haproxy", "-c", "-f" "{{ haproxy_docker_config_dir }}/haproxy.cfg"]', 'interval: 10s', 'timeout: 10s', 'retries: 3']|A Healthcheck for the Docker Container|
|`haproxy_docker_network_mode`|"bridge"|Be default haproxy will not get its own network assigned to it. You may change that here.|

You can find required CPU and memory Settings for your Setup [here](https://www.haproxy.com/documentation/haproxy-enterprise/getting-started/installation/linux/). You should always set Limitations for your Containers, because they can [impact the Host](https://docs.docker.com/config/containers/resource_constraints/).

If you want to Reload the HAProxy inside the Container execute this command: `docker kill -s USR2 {{ haproxy_docker_container_name }}`. Very useful after renewing TLS Certificates. On Configuration Change this Role also does this in the "Reload Docker HAProxy" Handler.

### Run a prebuild Image

If you plan to use the [Official Image](https://hub.docker.com/_/haproxy/) or any other prebuild Image, you should tinker with these Variables:

|Name|Default|Description|
|:--|:--|:--|
|`haproxy_docker_image`|`"{{ haproxy_docker_name }}:{{ haproxy_docker_patch_version }}"`|Set this to the full Path of your Image|
|`haproxy_docker_mounts`|`[source: "{{ haproxy_docker_dir }}/config", target: "{{ haproxy_docker_config_dir }}", type: "bind"]`|Here you can configure your Docker Mounts|

Look at the [EXAMPLE.md](EXAMPLE.md) for an Example on how to do this.

