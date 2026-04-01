# Example Playbooks

To use this Role install it from the Ansible Galaxy

Either from Shell on your local machine:

```shell
ansible-galaxy role install martin-micimo.haproxy
```

Or put it into a `requirements.yml` that can be installed with `ansible-galaxy install -r requirements.yml`

```yaml
roles:
  - name: martin-micimo.haproxy
```

For all Requirements for this Project look at the [requirements.yml](requirements.yml)

## Playbook System Simple

This will set up:
- A HAProxy Service will be installed on the System (managed by Systemd) with the Default Version for that System.
- A Prometheus Frontend for Metrics on the default Port 8404.
- A HTTP Frontend listening on Port 80, forwarding Traffic to the web_servers Backends.
- Three Backends in leastconn Balancing Mode.
- A Port Forward from 8080 to an SSH Port (22) on remote_backend in TCP Mode. Be extra careful with something like this.

```yaml
---
- name: Simple Haproxy Setup.
  hosts: debian-bookworm
  gather_facts: true
  become: true
  roles:
    - role: martin-micimo.haproxy
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
    - role: martin-micimo.haproxy
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
- :warning: Be extra careful with the exposed unsecured Prometheus Metrics Port 8404 here

```yaml
---
- name: Docker Compose Haproxy Setup.
  hosts: local
  gather_facts: true
  become: true
  roles:
    - role: martin-micimo.haproxy
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
- The User in the Docker Image that will run the HAProxy is named `harharproxy` instead of the default `haproxy`
- The smallest Configuration possible that HAProxy accept as valid. Totally useless, but valid.
- You must have a working [Docker Registry Authentification](https://docs.docker.com/reference/cli/docker/login/#examples) configured on the System for this to work.

```yaml
---
- name: Docker Compose Haproxy Setup.
  hosts: local
  gather_facts: true
  become: true
  roles:
    - role: martin-micimo.haproxy
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
    - role: martin-micimo.haproxy
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
