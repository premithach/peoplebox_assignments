def process(d):
    # Define a dictionary to map 'status' values to their corresponding output messages
    status_message_map = {
        'active': 'Active',   # If status is 'active', we print 'Active'
        'inactive': 'Inactive'  # If status is 'inactive', we print 'Inactive'
    }
    
    # Get the 'status' value from the dictionary `d`. 
    # If 'status' is missing, default to 'unknown' (this handles cases where the key doesn't exist).
    status = d.get('status', 'unknown')
    
    # Look up the status in the `status_message_map`. If the status is not found, default to 'Unknown'.
    print(status_message_map.get(status, 'Unknown'))
