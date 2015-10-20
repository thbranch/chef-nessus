# encoding: utf-8

require 'chefspec'
require 'spec_helper'

describe 'nessus::register' do
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

    it 'executes nesscli fetch --security-center when fetch-type is security-center' do
      expect(chef_run).to run_execute('/opt/nessus/sbin/nessuscli fetch --security-center && touch /tmp/nessus_activated_by_chef')
    end
  end

  context 'centos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['nessus']['fetch_type'] = 'register'
      end.converge(described_recipe)
    end
    it 'executes nesscli fetch --register when fetch-type is register' do
      expect(chef_run).to install_package('test')
      # expect(chef_run).to run_execute('/opt/nessus/sbin/nessuscli fetch --register demo-demo-demo-demo && /opt/nessus/sbin/nessuscli update --plugins-only && touch /tmp/nessus_activated_by_chef')
    end
  end
end

