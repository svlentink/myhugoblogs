---
title: "AzureDevOps using AzureAD groups"
date: "2025-04-03"
draft: false
tags: ["coding"]
---

In case you need to use AzureAD groups inside if AzureDevops, consider this an example of how you could do this using OpenTofu (Terraform).

This will add *AzureAD groups* to your Azure DevOps *Organization*,
which can be found under `Settings/Permissions`.


```hcl
data "azuredevops_group" "target" {
    name = "Project Collection Administrators"
}

data "azuread_group" "main" {
    for_each = toset(["user-group-x", "admin-group-y"])
    display_name = each.key
}
resource "azuredevops_group" "main" {
    for_each = data.azuread_group.main
    origin_id = each.value.object_id
}
resource "azuredevops_group_membership" "main" {
    mode = "add"
    group = data.azuredevops_group.target.descriptor
    members = concat(
        # Adding groups of users to your Azure DevOps Organization as Admin
        [for k,v in azuredevops_group.main : v.descriptor],
        # and also adding single users (e.g. service accounts)
        [for k,v in data.azuredevops_users.main : one(v.users).descriptor]
    )
}

data "azuredevops_users" "main" {
    for_each = toset(["sa-x@microsoft.com", "sa-y@ms.com"])
    principal_name = each.key
}
```
