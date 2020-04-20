# !/bin/bash
TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S` && #
cd repo && #
git archive -o ../${TIMESTAMP}.zip HEAD:src && #
cd .. && #
aws s3 cp ${TIMESTAMP}.zip s3://${PROJECT_NAME}-app/ --profile ${AWS_PROFILE} && #
echo Released version: ${TIMESTAMP}
