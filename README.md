# aws-kinesis 
 
Provisioning aws kinesis data stream using Terraform on mocked aws platform with Localstack and publishing random data records to Kinesis stream.
 
 
## Setup LocalStack 
 
```
install docker 
install docker-compose 
install python 
install pip 
 
pip install localstack 
 
clone the repository 

cd localstack 
export SERVICES=s3,lambda,kinesis,firehose,iam 
export HOSTNAME=127.0.0.1 
docker-compose up 
 ``` 
 
 
## Run Terrafrom Scripts 
 
 For some reason IAM resource provisioning with Localstack is giving below error:
 Error creating IAM Role firehose_role: SerializationError: failed decoding Query response
        status code: 200, request id: 
caused by: parsing time "2019-06-09 06:32:08.149610+00:00" as "2006-01-02T15:04:05Z": cannot parse " 06:32:08.149610+00:00" as "T"
From previous error reports on actual aws api, it looks like an issue with api.
However scripts can be tested with AWS by exporting aws credentials.

Note:
When running against actual aws api's make sure the user owning the access_key, and secret_key has sufficient permissions to create resources.


 ```
cd terraform 
export AWS_ACCESS_KEY_ID="xxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxxxxx"
export AWS_DEFAULT_REGION="ap-southeast-2"
terraform init 
terraform apply 
```
 
 
## Publish Data to Kinesis Stream 
 

 ```
cd data
export AWS_ACCESS_KEY_ID="xxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxxxxx"
export AWS_DEFAULT_REGION="ap-southeast-2"
python generator.py
```
 



## TODO
 
 Finetune the fire_hose policy to use Principle of Least Privillege
 
 

