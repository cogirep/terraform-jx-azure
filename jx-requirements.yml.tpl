apiVersion: core.jenkins-x.io/v4beta1
kind: Requirements
spec:
  cluster:
    provider: aks
    registry: ${registry_name}
    azure:
      storage:
        storageAccountName: ${storage_account_name}
  %{ if key_vault_enabled }
      secretStorage:
        keyVaultName: ${key_vault_name}
  %{ endif }
      dns:
        resourceGroup: ${dns_resource_group}
        tenantId: ${dns_tenant_id}
        subscriptionId: ${dns_subscription_id}
  environments:
    - key: dev
  ingress:
    domain: ${domain_name}
    externalDNS: ${domain_enabled}
    tls: {}
  %{ if key_vault_enabled }
  secretStorage: azurekeyvault
  %{ else }
  secretStorage: vault
  %{ endif }
  storage:
    - name: logs
      url: azblob://${log_container_name}
  terraformVault: ${vault_installed}
