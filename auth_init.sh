#!/bin/bash -l

#See here for where I got the escape subs: https://unix.stackexchange.com/questions/598461/how-to-espace-sequence-of-characters-in-sed
#Also see these:
#https://stackoverflow.com/questions/29613304/is-it-possible-to-escape-regex-metacharacters-reliably-with-sed
#https://stackoverflow.com/questions/2854655/command-to-escape-a-string-in-bash
#https://stackoverflow.com/questions/7680504/sed-substitution-with-bash-variables

AUTH_INFO=$(aws ecr get-authorization-token --output text)
ECR_TOKEN=$(echo "$AUTH_INFO" | cut -f2)
ECR_TOKEN_EXPIRES=$(echo "$AUTH_INFO" | cut -f3)
ECR_TOKEN_ENDPOINT=$(echo "$AUTH_INFO" | cut -f4)
ECR_TOKEN_ENDPOINT=${ECR_TOKEN_ENDPOINT//'\'/'\\'}
ECR_TOKEN_ENDPOINT=${ECR_TOKEN_ENDPOINT//'/'/'\/'}
ECR_TOKEN_ENDPOINT=${ECR_TOKEN_ENDPOINT//':'/'\:'}
ECR_TOKEN_ENDPOINT=${ECR_TOKEN_ENDPOINT//'.'/'\.'}
ECR_TOKEN_ENDPOINT=${ECR_TOKEN_ENDPOINT//'-'/'\-'}
SED_CMD="sed -i s/__ECR_ENDPOINT__/$ECR_TOKEN_ENDPOINT/g /etc/apache2/sites-available/default-ssl.conf"
$($SED_CMD)
ECR_TOKEN=$ECR_TOKEN eval 'apachectl -k start'
