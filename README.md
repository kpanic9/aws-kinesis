# aws-kinesis 
 
Provisioning aws kinesis data stream using Terraform on mocked aws platform with Localstack. 
 
 
## Setup LocalStack 
 
install docker 
install docker-compose 
install python 
install pip 
 
```
pip install localstack 
 ```
 
clone the repository 
```
cd localstack 
export SERVICES=s3,lambda,kinesis,firehose,iam 
export HOSTNAME=127.0.0.1 
docker-compose up 
 ``` 
 
 
## Run Terrafrom Scripts 
 
 ```
cd terraform 
export AWS_ACCESS_KEY_ID="xxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxxxxx"
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