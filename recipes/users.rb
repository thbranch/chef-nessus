#
# Cookbook Name:: nessus
# Recipe:: users
#
# Copyright (C) 2015 dann s washko
#
# All rights reserved - Do Not Redistribute
#

package 'expect' do
  action :install
end

nessuscli = "#{node['nessus']['rootdir']}/sbin/nessuscli"

# users = chef_vault_item(node['nessus']['vault'], node['nessus']['vault_users_item']).dup
# users.delete('id') # remove the id key/val

node['nessus']['user_databags'].each do |dbag|
  opt = data_bag_item('nessus', dbag)

  bash 'nessus_add_user' do
    user 'root'
    code <<-EOF
      /usr/bin/expect -c 'spawn #{nessuscli} adduser
      expect "Login : "
      send "#{opt['login']}\r"

      expect "Login password : "
      send "#{opt['password']}\r"
      expect "Login password (again) : "
      send "#{opt['password']}\r"

      expect "Do you want"
      send "y\r"

      sleep 5
      send "\r"

      expect "Is that ok "
      send "y\r"

      expect eof'
    EOF
  end
end
