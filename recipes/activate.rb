#
# Cookbook Name:: nessus
# Recipe:: register
#
# Copyright (C) 2015 dann s washko
#
# All rights reserved - Do Not Redistribute
#

# Activate! subscription

nessuscli = "#{node['nessus']['rootdir']}/sbin/nessuscli"
case node['nessus']['fetch_type']
when 'security-center'
  execute 'nessuscli-fetch' do
    command "#{nessuscli} fetch --security-center && touch /tmp/nessus_activated_by_chef"
  end
when 'register'
  execute 'nessuscli-fetch' do
    command "#{nessuscli} fetch --register #{node['nessus']['register_serial']} && \
              #{nessuscli} update --plugins-only && \
              touch /tmp/nessus_activated_by_chef"
  end
end

# notify if action failed
log 'Nessus: Activiation FAILED' do
  level :warn
  only_if { !File.exist?('/tmp/nessus_activated_by_chef') }
end
