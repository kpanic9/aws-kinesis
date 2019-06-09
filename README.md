# aws-kinesis
Provisioning aws kinesis data stream using Terraform on mocked aws platform with Localstack.


install docker
install docker-compose
pip install localstack

clone the repository
cd localstack
export SERVICES=s3,lambda,kinesis,firehose
docker-compose up


