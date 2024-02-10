#!/bin/bash
ACCOUNT_ID="$1"
REGION="$2"

# AWS IAM role ARN to be assumed
role_arn="arn:aws:iam::${ACCOUNT_ID}:role/tfbuilder"

# AWS CLI assume-role command
assume_role_output=$(aws sts assume-role --role-arn "$role_arn" --role-session-name "AssumeRoleSession")

# Extracting temporary credentials
export AWS_ACCESS_KEY_ID=$(echo "$assume_role_output" | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo "$assume_role_output" | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo "$assume_role_output" | jq -r '.Credentials.SessionToken')

# Set AWS default region
export AWS_DEFAULT_REGION="${REGION}"

# Display assumed role details
echo "Assumed role: $role_arn"
echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
echo "AWS_SESSION_TOKEN: $AWS_SESSION_TOKEN"
echo "AWS_DEFAULT_REGION: $AWS_DEFAULT_REGION"
