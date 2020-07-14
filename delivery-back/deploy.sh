#!/bin/bash
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# VARIABLES STANDAR
ENV=XXXXXX #THIS WORK FINE IF WE USE SAM IN LOCAL. IN PIPELINE IS NOT NEED
BUCKET=XXXXXX #BUCKET IS REQUIRED FOR SAM PACKAGE

STACK=XXXXXX-bakend-$ENV #NAME OF STACK, IS IMPORTANT FOR THE NAME OF ALL OBJECTS IN TEMPLATE
PROJECT=XXXXXX #PROJECT NAME FOR THE TAGS
REPOSITORY_NAME="XXXX" #REPOSITORY NAME FOR CODE-COMMIT

AWS_PROFILE=droptek-prod

cd $SOURCE
echo -e "${YELLOW} Packaing SAM  cloudformation..."
echo -e " =========================${NC}"
sam package --template-file ./template.yaml --output-template-file packaged-template.yaml --s3-bucket $BUCKET
echo 'Deplot SAM  cloudformation...'
echo -e "${YELLOW} Deploy SAM  cloudformation..."
echo -e " =============================== ${NC}"
sam deploy --template-file packaged-template.yaml --stack-name $STACK --tags Project=$PROJECT --parameter-overrides ProjectId=$PROJECT RepositoryName=$REPOSITORY_NAME --capabilities CAPABILITY_NAMED_IAM