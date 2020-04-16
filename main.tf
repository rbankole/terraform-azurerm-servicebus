resource "azurerm_servicebus_namespace" "namespace" {
  resource_group_name = terraform.workspace
  name                = var.namespace_name != "" ? var.namespace_name : "${local.rg_name}-sb-ns"
  location            = local.rg_location
  sku                 = var.namespace_sku
  capacity            = var.namespace_capacity
  zone_redundant      = var.namespace_sku == "premium" ? var.redundency : false
  tags                = var.tags
}

resource "azurerm_servicebus_queue" "queue" {
  count               = length(var.queues)
  name                = element(var.queues, count.index)
  resource_group_name = terraform.workspace
  namespace_name      = azurerm_servicebus_namespace.namespace.name
}

resource "azurerm_servicebus_topic" "topic" {
  count               = var.namespace_sku != "basic" ? length(var.topics) : 0
  name                = element(var.topics, count.index)
  resource_group_name = terraform.workspace
  namespace_name      = azurerm_servicebus_namespace.namespace.name
}

resource "azurerm_servicebus_subscription" "subscription" {
  count               = var.namespace_sku != "basic" ? length(var.topics) : 0
  name                = "${element(azurerm_servicebus_topic.topic.*.name, count.index)}-sub"
  resource_group_name = terraform.workspace
  namespace_name      = azurerm_servicebus_namespace.namespace.name
  topic_name          = element(azurerm_servicebus_topic.topic.*.name, count.index)
  max_delivery_count  = var.servicebus_subscription_max_delivery_count
}

