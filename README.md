# terraform-azurerm-servicebus



Terraform Module to Create a ServiceBus in Azure with (optional) queues and topics

```hcl
module "servicebus" {
  source = "jungopro/servicebus/azurerm"
}
```

## Example for Premium Namespace with queses, topics and subscriptions

```hcl
module "servicebus" {
  source                                     = "jungopro/servicebus/azurerm"
  create_resource_group                      = true
  resource_group_name                        = "sb-rg"
  namespace_name                             = "mycustomsbns"
  namespace_sku                              = "premium"
  namespace_capacity                         = 4
  redundency                                 = true
  queues                                     = ["queue1"]
  topics                                     = ["topic1"]
  servicebus_subscription_max_delivery_count = 3

  tags = {
    environment = "dev"
  }
}
```