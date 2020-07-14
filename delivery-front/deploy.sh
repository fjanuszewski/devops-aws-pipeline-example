#!/bin/bash
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
#VARIABLES ESTANDAR
SOURCE="$(pwd)"
BUCKET=serverlesswebexample

STACK=serverlessweb-delivery
PROJECT=serverlessweb
ENVIRONMENT=develop
REPOSITORY_NAME="serverlesswebexample-front"

cd $SOURCE
echo -e "${YELLOW} Packaing SAM  cloudformation..."
echo -e " =========================${NC}"
sam package --template-file ./template.yaml --output-template-file packaged-template.yaml --s3-bucket $BUCKET
echo 'Building SAM  cloudformation...'
echo -e "${YELLOW} Building SAM  cloudformation..."
echo -e " =============================== ${NC}"
sam deploy --template-file packaged-template.yaml --stack-name $STACK --tags Project=$PROJECT --parameter-overrides ProjectId=$PROJECT RepositoryName=$REPOSITORY_NAME --capabilities CAPABILITY_NAMED_IAM