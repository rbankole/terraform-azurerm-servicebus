locals {
  rg_name     = var.create_resource_group ? azurerm_resource_group.rg[0].name : var.resource_group_name
  rg_location = var.create_resource_group ? azurerm_resource_group.rg[0].location : var.resource_group_location
}


resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0 # conditional creation
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.tags
}

resource "azurerm_servicebus_namespace" "namespace" {
  resource_group_name = local.rg_name
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
  resource_group_name = local.rg_name
  namespace_name      = azurerm_servicebus_namespace.namespace.name
}

resource "azurerm_servicebus_topic" "topic" {
  count               = var.namespace_sku != "basic" ? length(var.topics) : 0
  name                = element(var.topics, count.index)
  resource_group_name = local.rg_name
  namespace_name      = azurerm_servicebus_namespace.namespace.name
}

resource "azurerm_servicebus_subscription" "subscription" {
  count               = var.namespace_sku != "basic" ? length(var.topics) : 0
  name                = "${element(azurerm_servicebus_topic.topic.*.name, count.index)}-sub"
  resource_group_name = local.rg_name
  namespace_name      = azurerm_servicebus_namespace.namespace.name
  topic_name          = element(azurerm_servicebus_topic.topic.*.name, count.index)
  max_delivery_count  = 1
}

