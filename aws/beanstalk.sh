## Upload artifact to s3 bucket
aws s3 cp ./build/libs/simple-cloud-app-0.0.1-SNAPSHOT.jar s3://elasticbeanstalk-us-west-2-693568640595

## Creating and deploying application to elastic beanstalk
## 1. Creaet a elastic beanstalk application
aws elasticbeanstalk create-application --application-name simple-cloud-app --description "Simple cloud spring boot app"

## 2. Create a application version and point to S3 bucket name, key name
aws elasticbeanstalk create-application-version --application-name simple-cloud-app --version-label sca-v1 --description sca-v1-descr --source-bundle S3Bucket="elasticbeanstalk-us-west-2-693568640595",S3Key="simple-cloud-app-0.0.1-SNAPSHOT.jar" --auto-create-application

## 3. Create a new environment dev,test etc. with the application version. Also, specify a cname-prefix for the URL.
## Please note that cname-prefix should be unique across AWS. If the commands throws error, change the cname-prefix to a different value
##    Replace the local file path for env-options.json accordingly
aws elasticbeanstalk create-environment --application-name simple-cloud-app --environment-name SimpleCloudApp-env-dev --cname-prefix SimpleCloudApp-prefix --version-label sca-v1 --solution-stack-name "64bit Amazon Linux 2018.03 v2.7.6 running Java 8" --tier Name="WebServer",Type="Standard"

## 4. Get the URL of this environment. Navigate to "AWS Management console > Elastic Beanstalk" and monitor the status of environment creation
aws elasticbeanstalk describe-environments --environment-names SimpleCloudApp-env-dev --application-name simple-cloud-app --query 'Environments[0].{URL:CNAME}'

curl -Xget http://simplecloudapp-env-dev.sphwbid66p.us-west-2.elasticbeanstalk.com/manage/info


