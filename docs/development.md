# Development

This document describes the development workflow for the project.

## Prerequisites

- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://www.terraform.io/downloads.html)
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

## Organizing the workspace

Please use `.vscode/eks_karpenter.code-workspace` to open the workspace in VSCode.
This will ensure that the workspace is properly configured for development.
Additionally, look up the required extensions in workspace file and install them.
It will prompt you to install the required extensions if you don't have them.

### Contributing

Make sure the linter is installed and running before contributing to the project.
Make `tf fmt` and `tf validate` part of your workflow to ensure that
the code is properly formatted and validated.
