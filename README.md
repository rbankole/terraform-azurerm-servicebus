# terraform-azurerm-servicebus



Terraform Module to Create a ServiceBus in Azure with (optional) queues and topics

```hcl
module "app" {
  source = "jungopro/app/azuread"
}
```

## Example with custom values

```hcl
module "app" {
  source                = "jungopro/app/azuread"
  app_name              = "mycustomApp
  identifier_urls       = ["http://app.domain.com","http://my.domain.com"]
  reply_urls            = ["http://app.domain.com","http://my.domain.com"]
  generate_spn_password = false # supply your own value in the next key
  spn_password          = "MySecret$pnPassw0rD!"
}
```