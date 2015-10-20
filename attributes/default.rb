# Install
default['nessus']['installer_file'] = nil
default['nessus']['installer_file_url'] = nil
default['nessus']['rootdir'] = '/opt/nessus'

# Activation
default['nessus']['register'] = true
default['nessus']['fetch_type'] = 'security-center'
default['nessus']['register_serial'] = 'demo-demo-demo-demo'

# Users
# default['nessus']['vault'] = nil
# default['nessus']['vault_users_item'] = nil
default['nessus']['create_user'] = true
default['nessus']['user_databags'] = ['agent', 'user']
