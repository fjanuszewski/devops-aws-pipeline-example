const AWS = require('aws-sdk');
const cloudformation = new AWS.CloudFormation();
const cloudfront = new AWS.CloudFront();
const codepipeline = new AWS.CodePipeline();

exports.handler = async (event) => {
  console.log("EVENT:", JSON.stringify(event))
  const result = await cloudformation.listExports().promise();
  const resultado = result.Exports.find(data => data.Name === event["CodePipeline.job"].data.actionConfiguration.configuration.UserParameters);
  console.log("DISTRIBUTION-ID:", JSON.stringify(resultado.Value))
  var params = {
    DistributionId: resultado.Value,
    InvalidationBatch: {
      CallerReference: (new Date()) + "",
      Paths: {
        Quantity: '1',
        Items: [
          '/*',
        ]
      }
    }
  };
  const invalidationData = await cloudfront.createInvalidation(params).promise();
  console.log("INVALIDATION-ID:", JSON.stringify(invalidationData))
  const resultJob = await codepipeline.putJobSuccessResult({ jobId: event["CodePipeline.job"].id }).promise();
  console.log("RESULTJOB-ID:", JSON.stringify(resultJob))

};