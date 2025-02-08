import json,boto3

def lambda_handler(event, context):
    # read from data file, do password comparison
    instance_id = None
    hosted_zone_id = None
    target_domain = None
    with open('data.json') as json_file:
        data = json.load(json_file)
        if (event['password'] != data['password']):
            return 'Incorrect Password!'
        instance_id = data['instance-id']
        hosted_zone_id = data['hosted-zone-id']
        target_domain = data['target-domain']
    
    # start ec2 instance
    ec2_client = boto3.client('ec2')
    ec2_client.start_instances(InstanceIds = [instance_id])
    ret = 'Success!'
    
    # check to see if wait exists
    doWait = False
    try:
        event['wait']
        doWait = True
    except:
        doWait = False
    if doWait:
        # wait to update instance data
        waiter = ec2_client.get_waiter('instance_running')
        waiter.wait(InstanceIds = [instance_id])
        instance_info = ec2_client.describe_instances(InstanceIds = [instance_id])
        ip = instance_info['Reservations'][0]['Instances'][0]['PublicIpAddress']
        ret += ' Public IP Address: ' + ip + '.'
    
    ret += ' Server will be hosted at mc.capprin.net; wait 0-5 minutes for DNS to update.'
    return ret
