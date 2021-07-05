module "vpc" {
  source              = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork"
  name                = var.aws_vpc_name
  environment         = var.general_labels.environment
  az_count            = var.aws_vpc_az_count
  cidr_range          = var.aws_vpc_cidr
  private_cidr_ranges = var.aws_private_cidr_ranges
  public_cidr_ranges  = var.aws_public_cidr_ranges
  tags                = var.general_labels
}
