#
# Cookbook Name:: nessus
# Recipe:: default
#
# Copyright (C) 2015 dann s washko
#
# All rights reserved - Do Not Redistribute
#

if node['nessus']['installer_file'].nil?

  package 'Nessus' do
    action :install
  end

else

  rpm_package 'Nessus.rpm'

  installer_filename = Dir.glob(node.nessus.installer_file).first

  case File.extname(installer_filename)
  when '.deb'
    dpkg_package 'Nessus' do
      source installer_filename
      notifies :restart, 'service[nessusd]', :delayed
    end
  when '.rpm'
    rpm_package 'Nessus' do
      source installer_filename
      notifies :restart, 'service[nessusd]', :delayed
    end
  else
    log 'Nessus installer file not usable' do
      level :fatal
    end
  end
end

service 'nessusd' do
  action [:enable, :start]
end

include_recipe 'nessus::activate' if node['nessus']['register']

include_recipe 'nessus::users' if node['nessus']['create_user']
