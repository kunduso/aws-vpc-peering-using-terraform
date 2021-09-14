![Image](https://skdevops.files.wordpress.com/2021/08/48.image-1-3.png)
# aws-vpc-peering-using-terraform
## Motivation
A few weeks ago, I created a peering relationship between two VPCs that belonged to separate AWS accounts using Terraform. This repository contains the terraform configuration files to configure that.
<br/> Details are available on my notes at [VPC Peering using Terraform across separate AWS accounts.](https://skundunotes.com/2021/08/24/vpc-peering-using-terraform-across-separate-aws-accounts/)
<br/> I explored this idea further using an existing Terraform state file as a data source to access the details of VPCs to create a peering relationship. Details available on my notes at [Terraform remote state file as a data source to support a layered IAC approach](https://skundunotes.com/2021/09/14/terraform-remote-state-file-as-a-data-source-to-support-a-layered-iac-approach/)