#!/bin/bash

# Genereate the TF variables
echo
echo "Let's create the TF variables file"
echo

cat <<EOF > tf_iaas/terraforming-pas/terraform.tfvars
env_name           = “farb”
access_key         = “$ACCESS_KEY”
secret_key         = “$SECRET_KEY”
region             = “eu-central-1"
availability_zones = [“eu-central-1a”, “eu-central-1b”, “eu-central-1c”]
rds_instance_count = 1
dns_suffix         = “whizzosoftware.com”
hosted_zone        = “farb.whizzosoftware.com”
vpc_cidr           = “10.0.0.0/16"
ops_manager_ami    = “ami-08a1a17cbd9d0fbf9”
use_route53        = true
use_tcp_routes     = true

tags = {
   Team = “Dev”
   Project = “WebApp3”
}
EOF

echo
echo "TF variables file created"
echo

cd tf_iaas/terraforming-pas
echo "**********************************"
echo ">>>>>>>> Performing terraform init"
echo "**********************************"
echo
terraform init -input=false

echo "**********************************"
echo ">>>>>>>> Performing terraform apply"
echo "**********************************"
terraform apply -input=false -auto-approve -state=../../terraform-output/terraform.1.0.0.out

exit 0

