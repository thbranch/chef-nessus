#
# Cookbook Name:: nessus
# Recipe:: default
#
# Copyright (C) 2015 dann s washko
#
# All rights reserved - Do Not Redistribute
#

if node['platform_family'] == 'windows'
  log 'Windows now supported now' do
    level :fatal
  end
else
  include_recipe 'nessus::_install-linux'
end

include_recipe 'nessus::register' if node['nessus']['register']

include_recipe 'nessus::users' if node['nessus']['create_user']
