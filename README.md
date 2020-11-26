<!-- markdownlint-disable MD041 -->
<p align="center"><a href="https://github.com/fredrikhgrelland/vagrant-hashistack-template" alt="Built on"><img src="https://img.shields.io/badge/Built%20from%20template-Vagrant--hashistack--template-blue?style=for-the-badge&logo=github"/></a><p align="center"><a href="https://github.com/fredrikhgrelland/vagrant-hashistack" alt="Built on"><img src="https://img.shields.io/badge/Powered%20by%20-Vagrant--hashistack-orange?style=for-the-badge&logo=vagrant"/></a></p></p>


# Terraform-nomad-nifi
This module is IaC - infrastructure as code which contains a nomad job of [nifi](https://nifi.apache.org/).

## Content
0. [Prerequisites](#prerequisites)
1. [Compatibility](#compatibility)
2. [Requirements](#requirements)
    1. [Required software](#required-software)
3. [Usage](#usage)
   1. [Providers](#providers)
   2. [Intentions](#intentions)
4. [Inputs](#inputs)
5. [Outputs](#outputs)
6. [Modes](#modes)
7. [Example](#example)
    1. [Verifying setup](#verifying-setup)
        1. [Data example upload](#data-example-upload)
8. [Authors](#authors)
9. [License](#license)
10. [References](#references)

## Prerequisites
Please follow [this section in original template](https://github.com/fredrikhgrelland/vagrant-hashistack-template#install-prerequisites)

## Compatibility
|Software|OSS Version|Enterprise Version|
|:---|:---|:---|
|Terraform|0.13.1 or newer||
|Consul|1.8.3 or newer|1.8.3 or newer|
|Vault|1.5.2.1 or newer|1.5.2.1 or newer|
|Nomad|0.12.3 or newer|0.12.3 or newer|

## Requirements

### Required software
All software is provided and run with docker.
See the [Makefile](Makefile) for inspiration.

## Usage
The following command will run nifi in the [example/standalone](example/standalone) folder.
```sh
make up
```

### Providers
- [Nomad](https://registry.terraform.io/providers/hashicorp/nomad/latest/docs)
- [Vault](https://registry.terraform.io/providers/hashicorp/vault/latest/docs)

### Intentions
Module is deployed with [service mesh approach using consul-connect integration](https://www.consul.io/docs/connect), where [communication `service-to-service` controlled by intentions](https://learn.hashicorp.com/tutorials/consul/get-started-service-networking#control-communication-with-intentions).
Intentions are required **`only`** when [consul acl is enabled and default_policy is deny](https://learn.hashicorp.com/tutorials/consul/access-control-setup-production#enable-acls-on-the-agents).


## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| nomad\_datacenters | Nomad data centers | list(string) | ["dc1"] | yes |
| nomad\_namespace | [Enterprise] Nomad namespace | string | "default" | yes |
| nomad\_host\_volume | Nomad host volume | string | "persistence" | no |
| service\_name | nifi service name | string | "nifi" | yes |
| host | Nifi host | string | "127.0.0.1" | yes |
| port | nifi container port | number | 8182 | yes |
| container\_image | nifi container image | string | "apache/nifi:latest" | yes |
| resource | Resource allocations for cpu and memory | obj(number, number)| { <br> cpu = 500, <br> memory = 1024 <br> } | no |
| resource_proxy | Resource allocations for proxy | obj(number, number)| { <br> cpu = 200, <br> memory = 128 <br> } | no |
| use\_host\_volume | Switch to enable or disable host volume | bool | false | no |
| use\_canary | Uses canary deployment for nifi | bool | false | no |

## Outputs
| Name | Description | Type |
|------|-------------|------|
| service\_name | nifi service name | string |


## Example
The following code is an example of the Nifi module. For detailed information check the [example/standalone](/example/standalone).
```hcl-terraform
module "nifi" {
  source = "../.."

  # nomad
  nomad_datacenters = ["dc1"]
  nomad_namespace   = "default"

  # nifi
  service_name    = "nifi"
  host            = "127.0.0.1"
  port            = 8182
  container_image = "apache/nifi:1.12.1"
  resource_proxy = {
    cpu    = 200
    memory = 128
  }
}
```

### Verifying setup


#### Data example upload
Check [example/README.md#data-example-upload](example/README.md#data-example-upload)

## Authors

## License
This work is licensed under Apache 2 License. See [LICENSE](./LICENSE) for full details.

## References
