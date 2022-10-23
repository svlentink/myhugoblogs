---
title: "Dynamic configuration block in Terraform"
date: "2022-10-21"
draft: false
tags: ["terraform"]
---

Terraform allows conditional statements like if else for variables,
but not for configuration blocks.
After searching for a long time,
I came up with a way and decided to share it.

```hcl
resource "confluent_kafka_cluster" "cluster" {
  ...

  # For DEV and ACCept we want basic
  dynamic "basic" {
    for_each = var.env != "prd" ? ["not_empty_array"] : []
    content {}
  }
  # but for PRD we want standard
  dynamic "standard" {
    for_each = var.env == "prd" ? ["not_empty_array"] : []
    content {}
  }
}
```

