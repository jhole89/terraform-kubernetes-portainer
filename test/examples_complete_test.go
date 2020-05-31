package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"strconv"
	"testing"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	// Setup
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../examples/complete",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"kubeconf_path": "~/.kube/config",
			"config_user":   "minikube",
			"cluster_name":  "minikube",
		},
	}

	// Act
	terraform.InitAndApply(t, terraformOptions)

	// Teardown
	defer terraform.Destroy(t, terraformOptions)

	// Test
	ingress := terraform.Output(t, terraformOptions, "ingress")
	assert.Equal(t, "[]", ingress)

	serviceUrl := terraform.Output(t, terraformOptions, "service_url")
	assert.Equal(t, "/api/v1/namespaces/my-portainer-ns/services/my-portainer-service", serviceUrl)

	namespace := terraform.Output(t, terraformOptions, "namespace")
	assert.Equal(t, "my-portainer-ns", namespace)

	serviceName := terraform.Output(t, terraformOptions, "service_name")
	assert.Equal(t, "my-portainer-service", serviceName)

	crbName := terraform.Output(t, terraformOptions, "crb_name")
	assert.Equal(t, "my-portainer-crb-clusteradmin", crbName)

	deploymentName := terraform.Output(t, terraformOptions, "deployment_name")
	assert.Equal(t, "my-portainer-deployment", deploymentName)

	pvcName := terraform.Output(t, terraformOptions, "pvc_name")
	assert.Equal(t, "my-portainer-pvc", pvcName)

	serviceAccountName := terraform.Output(t, terraformOptions, "service_account_name")
	assert.Equal(t, "my-portainer-sa-clusteradmin", serviceAccountName)

	serviceVersion := terraform.Output(t, terraformOptions, "service_version")
	i, err := strconv.Atoi(serviceVersion)

	if err != nil {
		assert.Greater(t, 0, i)
	}
}
