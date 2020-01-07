variable "create_resource_group" {
  description = "Option to create a Azure resource group to use for VNET"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created"
  default     = "myRG"
}

variable "resource_group_location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  default     = "westeurope"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "namespace_name" {
  description = "Specifies the name of the ServiceBus Namespace resource . Changing this forces a new resource to be created"
  default     = ""
}

variable "namespace_sku" {
  description = "Defines which tier to use. Options are basic, standard or premium"
  default     = "standard"
}

variable "namespace_capacity" {
  description = "Specifies the capacity. When sku is Premium, capacity can be 1, 2, 4 or 8. When sku is Basic or Standard, capacity can be 0 only"
  default     = 0
}

variable "redundency" {
  description = "Whether or not this resource is zone redundant. sku needs to be Premium. Defaults to false."
  default     = false
}

variable "queues" {
  description = "List of queues to create"
  type        = list(string)
  default     = ["queue1"]
}

variable "topics" {
  description = "List of topics to create"
  type        = list(string)
  default     = ["topic1"]
}