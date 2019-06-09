import boto3
import json
from datetime import datetime
import calendar
import random
import time

kinesis_stream = 'kinesis_app_stream'
client = boto3.client('kinesis', region_name='ap-southeast-2')

while True:
    record = {
        'prop': str(random.randint(40, 120)),
        'timestamp': str(calendar.timegm(datetime.utcnow().timetuple())),
        'type_id': 'xxxx'
    }
    print "Writing record to stream...."
    print record
    response = client.put_record(StreamName=kinesis_stream, Data=json.dumps(record), PartitionKey='type_id')
    print str(response)

    # wait for 5 second to slow down
    time.sleep(5)
