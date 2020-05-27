# terraform-kubernetes-portainer
[![Verify](https://github.com/jhole89/terraform-kubernetes-portainer/workflows/Verify/badge.svg?branch=master)](https://github.com/jhole89/terraform-kubernetes-portainer/actions?query=workflow%3AVerify)
[![Latest Release](https://badgen.net/github/release/jhole89/terraform-kubernetes-portainer)](https://github.com/jhole89/terraform-kubernetes-portainer/releases/latest)

`terraform-kubernetes-portainer` is a Terraform module for running [Portainer](https://www.portainer.io/) on a 
[Kubernetes](https://kubernetes.io/) cluster.

:warning: This is not production-ready, due to having an upwards dependency on the 
[portainer-k8s-beta image](https://hub.docker.com/r/portainer/portainer-k8s-beta) which itself is only in beta. :warning:

## Features

The module will create the following Kubernetes resources:

   * Kubernetes Namespace
   * Kubernetes ServiceAccount
   * Kubernetes ClusterRoleBinding
   * Kubernetes Deployment
   * Kubernetes Service with LoadBalancer

---

This module is 100% Open Source and licensed under the [APACHE2](LICENSE).

## Usage


**IMPORTANT:** The `master` branch is used in `examples` just as an example. Do not pin to `master` because there may 
be breaking changes between releases. Instead, pin to the release tag (e.g. `?ref=tags/x.y.z`) from 
[latest releases](https://github.com/jhole89/terraform-kubernetes-portainer/releases).

For a complete example, see [examples/complete](examples/complete).
