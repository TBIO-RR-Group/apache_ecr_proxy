#!/bin/bash -l

AUTH_INFO=$(aws ecr get-authorization-token --output text)
ECR_TOKEN=$(echo "$AUTH_INFO" | cut -f2)
ECR_TOKEN_EXPIRES=$(echo "$AUTH_INFO" | cut -f3)
ECR_TOKEN_ENDPOINT=$(echo "$AUTH_INFO" | cut -f4)
#Restart Apache with new token:
ECR_TOKEN=$ECR_TOKEN eval 'apachectl -k graceful'
