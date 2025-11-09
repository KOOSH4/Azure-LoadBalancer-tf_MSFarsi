````markdown
# Azure Bootstrap & Terraform Deployment

## 1. Login to Azure
```bash
az login
````

## 2. Deploy Bootstrap Template

```bash
az deployment group create \
  --resource-group rg-kolad-sch \
  --template-file bootstrap.bicep
```

## 3. Grant Permissions

Assign an **RBAC role** (e.g., `Contributor`) to your new **Managed Identity** so it can create Azure resources.

## 4. Configure Terraform

Create your Terraform files:
add azure rm and backend
* `main.tf`
* `providers.tf`

In the backend block, reference the **storage account** created by the bootstrap step.

## 5. Add GitHub Secrets

In your GitHub repository, add these secrets:

* `AZURE_CLIENT_ID`
* `AZURE_TENANT_ID`
* `AZURE_SUBSCRIPTION_ID`

Click Add variable and create the same three variables you created at the repository level:
Name: BACKEND_RESOURCE_GROUP_NAME, Value: rg-kolad-sch
Name: BACKEND_STORAGE_ACCOUNT_NAME, Value: sttfwsslabsec001
Name: BACKEND_CONTAINER_NAME, Value: tfstate

## 6. Build GitHub Actions Workflow

Create a workflow YAML file that:

* Logs into Azure using the secrets
* Runs `terraform plan` and `terraform apply`

## 7. Push and Deploy

Commit your Terraform code and workflow file to trigger deployment.

```
```
