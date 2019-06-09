import boto3
import json
from datetime import datetime
import calendar
import random
import time

kinesis_stream = 'kinesis_app_stream'
client = boto3.client('kinesis', region_name='ap-southeast-2')

print 'Writing records to Kinesis stream....\n'
while True:

    # creating record
    record = {
        'value': str(random.randint(40, 120)),
        'timestamp': str(calendar.timegm(datetime.utcnow().timetuple())),
        'type_id': 'aws-kinesis'
    }

    # put record
    response = client.put_record(StreamName=kinesis_stream, Data=json.dumps(record), PartitionKey='type_id')
    
    # logs
    print '-----------------------------------------------------------------------'
    print record
    if response['ResponseMetadata']['HTTPStatusCode'] == 200:
        print 'Status: {0}'.format('Success')
        print 'SequenceNumber: {0}'.format(response['SequenceNumber'])
    else:
        print 'Status: {0}'.format('Failure')
    print '\n'

    # wait for 5 second to slow down
    time.sleep(5)
