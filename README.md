# terraform-kubernetes-portainer
[![Local Verify](https://github.com/jhole89/terraform-kubernetes-portainer/workflows/Verify/badge.svg?branch=master)](https://github.com/jhole89/terraform-kubernetes-portainer/actions?query=workflow%3AVerify)
[![Cluster E2E](https://github.com/jhole89/terraform-kubernetes-portainer/workflows/Cluster%20E2E/badge.svg?branch=master)](https://github.com/jhole89/terraform-kubernetes-portainer/actions?query=workflow%3A%22Cluster+E2E%22)
[![Go Report Card](https://goreportcard.com/badge/github.com/jhole89/terraform-kubernetes-portainer)](https://goreportcard.com/report/github.com/jhole89/terraform-kubernetes-portainer)
[![Latest Release](https://badgen.net/github/release/jhole89/terraform-kubernetes-portainer)](https://github.com/jhole89/terraform-kubernetes-portainer/releases/latest)
[![TF Registry](https://badgen.net/badge/icon/terraform?icon=terraform&label)](https://registry.terraform.io/modules/jhole89/portainer/kubernetes)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

`terraform-kubernetes-portainer` is a Terraform module for running [Portainer](https://www.portainer.io/) on a 
[Kubernetes](https://kubernetes.io/) cluster. [Portainer](https://www.portainer.io/) enables you to deploy applications
to your [Kubernetes](https://kubernetes.io/) cluster without the need for manifests or helm charts. It is available
through the [Terraform registry](https://registry.terraform.io/modules/jhole89/portainer/kubernetes).

[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/fold_left.svg?style=social&label=Follow%20%40JoelLutman)](https://twitter.com/joellutman)

## Important note :warning:

This has an upwards dependency on the [portainer-k8s-beta image](https://hub.docker.com/r/portainer/portainer-k8s-beta) 
which itself is only in beta.

## Features

The module will create the following Kubernetes resources:

   * Kubernetes Namespace
   * Kubernetes ServiceAccount
   * Kubernetes ClusterRoleBinding
   * Kubernetes PersistentVolumeClaim
   * Kubernetes Deployment
   * Kubernetes Service with LoadBalancer

## Usage example

For a complete example, see [examples/complete](examples/complete).

```hcl
provider "kubernetes" {
  config_path = var.kubeconf_path

  config_context_auth_info = var.config_user
  config_context_cluster   = var.cluster_name
}

module "portainer" {
  source       = "jhole89/portainer/kubernetes"
  version      = "1.0.0"
}
```

**IMPORTANT:** The `master` branch is used in `examples` just as an example. Do not pin to `master` because there may 
be breaking changes between releases. Instead, pin to the release tag (e.g. `?ref=tags/x.y.z`) from 
[latest releases](https://github.com/jhole89/terraform-kubernetes-portainer/releases).

<!--- BEGIN_TF_DOCS ---> 
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| kubernetes | ~> 1.11 |

## Providers

| Name | Version |
|------|---------|
| kubernetes | ~> 1.11 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| edge\_port | Agent EDGE port. | `number` | `8000` | no |
| http\_port | LoadBalancer HTTP port. | `number` | `9000` | no |
| image | Docker image. | `string` | `"portainer/portainer-k8s-beta:linux-amd64"` | no |
| labels | App labels to be used for namespace, service, and deployment. | `map(string)` | `{}` | no |
| name | App name to be used for namespace, service, and deployment. | `string` | `"portainer"` | no |
| service\_type | Determines how the service is exposed | `string` | `"ClusterIP"` | no |
| storage\_class | Persisted Volume storage class | `string` | `"local-path"` | no |
| storage\_size | Persisted Volume storage size | `string` | `"128Mi"` | no |

## Outputs

| Name | Description |
|------|-------------|
| crb\_name | n/a |
| deployment\_name | n/a |
| ingress | n/a |
| namespace | n/a |
| pvc\_name | n/a |
| service\_account\_name | n/a |
| service\_name | n/a |
| service\_url | n/a |
| service\_version | n/a |

<!--- END_TF_DOCS --->

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/jhole89/terraform-kubernetes-portainer/issues/new) section.

Full contributing [guidelines are covered here](https://github.com/jhole89/terraform-kubernetes-portainer/blob/master/.github/CONTRIBUTING.md).

## Authors

Created by [Joel Lutman](https://github.com/jhole89) - [joel.lutman@gmail.com](mailto:joel.lutman@gmail.com)

## License

This module is 100% Open Source and licensed under the [APACHE2](LICENSE).

## Share the Love 

Like this project? Please give it a ★ on [GitHub](https://github.com/jhole89/terraform-kubernetes-portainer)! (it helps **a lot**) 
