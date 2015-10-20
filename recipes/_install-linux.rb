#
# Cookbook Name:: nessus
# Recipe:: _install-linux
#
# Copyright (C) 2015 dann s washko
#
# All rights reserved - Do Not Redistribute
#

if node['nessus']['installer_file_url'].nil?
  package 'Nessus' do
    action :install
  end
else
  installer_filename = "/tmp/#{node['nessus']['installer_file']}"
  remote_file installer_filename do
    source "#{node['nessus']['installer_file_url']}/#{node['installer_file']}"
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  case node['platform']
  when 'debian', 'ubuntu'
    dpkg_package 'Nessus' do
      source installer_filename
      notifies :restart, 'service[nessusd]', :delayed
    end
  when 'redhat', 'centos', 'fedora', 'scientific'
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
