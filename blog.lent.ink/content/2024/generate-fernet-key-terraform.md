---
title: "Generate Fernet key using Terraform"
date: "2024-05-13"
draft: false
tags: ["terraform", "coding"]
---

Fernet keys can be generated using Python or OpenSSL,
but what if you want to manage the key as part of your infra in Terraform/OpenTofu?

```hcl
resource "random_password" "fernet" {
  length = 32
}

resource "azurerm_key_vault_secret" "fernet" {

  value = base64encode(random_password.fernet.result)

  name  = "fernet-key"
  key_vault_id = azurerm_key_vault.key_vault.id
}

```

