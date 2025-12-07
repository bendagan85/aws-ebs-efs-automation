#!/bin/bash
# AWS CLI command to launch EC2 with EBS and UserData for EFS

aws ec2 run-instances \
    --region us-east-1 \
    --image-id ami-0ecb62995f68bb549 \
    --count 1 \
    --instance-type t3.micro \
    --key-name YOUR_KEY_NAME \
    --subnet-id YOUR_SUBNET_ID \
    --security-group-ids YOUR_SECURITY_GROUP_ID \
    --block-device-mappings '[{"DeviceName":"/dev/sdb","Ebs":{"VolumeSize":10,"VolumeType":"gp3"}}]' \
    --user-data file://userdata.sh \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Hybrid-Storage-Server}]'
