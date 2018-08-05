# OpenStack Cleaner

Openstack cleaner contains rake tasks to cleanup resources in your openstack project. It is recommended to destroy the whole openstack project and recreate it. But when you do not have enough permissions to do so, these scripts can be helpful.

# What can it do ?

  - Clean dangling networks
  - Clean dangling routers
  - Clean instances and the associated resources connected to it

# How can it be done ?

Source your RC file from openstack which exports OS_PROJECT_ID, OS_PROJECT_NAME, OS_USER_DOMAIN_NAME, OS_USERNAME, OS_PASSWORD, OS_INTERFACE, OS_IDENTITY_API_VERSION

##### Clean dangling networks  
```  
rake dangling_networks
rake clean_dangling_networks
```

##### Clean dangling routers
```
rake dangling_routers
rake clean_dangling_routers
```

##### Clean instances and the associated resources connected to it
```
rake clean_servers exclude_networks="MAIN_NETWORK,ANOTHER_MAIN" servers="a.example.com,b.example.com" 
```

Be extremely cautious when running the above command. Do not miss your main network in the `exclude_networks`. You might end up deleting the whole network.

### Installation

Openstack cleaner requires
- Python
- [python-openstackclient](https://pypi.org/project/python-openstackclient/)
- Ruby
