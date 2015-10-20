# encoding: utf-8

require 'chefspec'
require 'spec_helper'

describe 'nessus::_install-linux' do
  before do
    stub_command("/usr/sbin/httpd -t").and_return(true)
    stub_command("which sudo").and_return(true)
    stub_data_bag_item('users', 'test').and_return({id: "test", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'fhanson').and_return({id: "fhanson", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'rgindes').and_return({id: "rgindes", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'jneves').and_return({id: "jneves", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'jcrawford').and_return({id: "jcrawford", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'blieberman').and_return({id: "blieberman", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'akemner').and_return({id: "akemner", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'rabdill').and_return({id: "rabdill", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'nessus').and_return({id: "nessus", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('nessus', 'agent').and_return({id: "agent", login: "agent", password: "test", admin: "y" })
    stub_data_bag_item('nessus', 'user').and_return({id: "user", login: "user", password: "test", admin: "n" })
  end
  context 'centos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
      end.converge(described_recipe)
    end

    it 'install package Nessus if installer_file_name is nil' do
      expect(chef_run).to install_package('Nessus')
    end

    it 'enables and starts the Nessusd service' do
      expect(chef_run).to enable_service('nessusd')
      expect(chef_run).to start_service('nessusd')
    end
  end

  context 'on centos with remote file' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        :platform => 'centos',
        :version => '6.6'
      ) do |node|
        node.set['nessus']['installer_file_url'] = 'http://demo.com'
        node.set['nessus']['installer_file'] = 'Nessus.rpm'
      end.converge(described_recipe)
    end

    it 'creates file /tmp/Nessus.rpm from remote file resource' do
      expect(chef_run).to create_remote_file('/tmp/Nessus.rpm')
    end

    it 'installs installer_file rpm with rpm_package' do
      expect(chef_run).to install_rpm_package('Nessus')
    end
  end

  context 'on debian with remote file' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        :platform => 'debian',
        :version => '7.2'
      ) do |node|
        node.set['nessus']['installer_file_url'] = 'http://demo.com'
        node.set['nessus']['installer_file'] = 'Nessus.deb'
      end.converge(described_recipe)
    end

    it 'creates file /tmp/Nessus.deb from remote file resource' do
      expect(chef_run).to create_remote_file('/tmp/Nessus.deb')
    end

    it 'installs installer_file deb with dpkg_package' do
      expect(chef_run).to install_dpkg_package('Nessus')
    end
  end
end

