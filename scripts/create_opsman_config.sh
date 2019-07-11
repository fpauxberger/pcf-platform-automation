#!/bin/bash
apt update -y
apt install -y jq

find .

REGION_NAME=`cat ../../terraform-output-s3/terraform.1.0.0.out | jq -r '.modules[0].outputs.region.value'`
VPCSUBNET_ID=`cat ../../terraform-output-s3/terraform.1.0.0.out | jq -r '.modules[0].outputs.management_subnet_ids.value[0]'`
SG_ID=`cat ../../terraform-output-s3/terraform.1.0.0.out | jq -r '.modules[0].outputs.ops_manager_security_group_id.value'`
KEYPAIR_NAME=`cat ../../terraform-output-s3/terraform.1.0.0.out | jq -r '.modules[0].outputs.ops_manager_ssh_public_key_name.value'`
INSTANCEPROFILE_NAME=`cat ../../terraform-output-s3/terraform.1.0.0.out | jq -r '.modules[0].outputs.ops_manager_iam_instance_profile_name.value'`

cat <<EOF > ../../opsmanconfig-output/opsman.yml
---
opsman-configuration:
  aws:
    region: $REGION_NAME
    vm_name: ops-manager-foundation
    vpc_subnet_id: $VPCSUBNET_ID
    security_group_id: $SG_ID
    key_pair_name: $KEYPAIR_NAME
    private_ip: 10.0.16.2
    use_instance_profile: true
    iam_instance_profile_name: $INSTANCEPROFILE_NAME

EOF
