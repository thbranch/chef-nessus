# encoding: utf-8

require 'chefspec'
require 'spec_helper'

describe 'nessus::default' do
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

    it 'installs package nessus' do
      chef_run.node.set['nessus']['installer_filename'] = nil
      expect(chef_run).to install_package('Nessus')
    end

    it 'installs rpm package Nessus' do
       chef_run.node.set['nessus']['installer_filename'] = 'Nessus.rpm'
      # allow(Dir).to receive(:glob?).and_return('Nessus.rpm')
      
      # File.stub(:extname?).with('Nessus.rpm').and_return('.rpm')
      expect(chef_run).to install_rpm_package('Nessus.rpm')
      # expect(chef_run).to notify('service[nessusd]').to(:restart).delayed
    end

    it 'starts and enables nessus service' do
      expect(chef_run).to enable_service('nessusd')
      expect(chef_run).to start_service('nessusd')
    end
  end
end

