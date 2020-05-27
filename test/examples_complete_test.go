package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
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
	}

	// Teardown
	defer terraform.Destroy(t, terraformOptions)

	// Act
	terraform.InitAndApply(t, terraformOptions)
}