# encoding: utf-8

require 'chefspec'
require 'spec_helper'

describe 'nessus::default' do
  before do
    stub_data_bag_item('nessus', 'agent').and_return({id: "agent", login: "agent", password: "test", admin: "y" })
    stub_data_bag_item('nessus', 'user').and_return({id: "user", login: "user", password: "test", admin: "n" })
  end
  context 'centos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
      end.converge(described_recipe)
    end

    it 'it includes recipe _install-linux if platform is linux' do
      expect(chef_run).to include_recipe('nessus::_install-linux')
    end

    it 'includes recipe register if register is true' do
      expect(chef_run).to include_recipe('nessus::register')
    end

    it 'includes recipe users if create_user is true' do
      expect(chef_run).to include_recipe('nessus::users')
    end
  end
end

