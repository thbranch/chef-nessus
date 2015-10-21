# encoding: utf-8

require 'chefspec'
require 'spec_helper'

describe 'nessus::users' do
  before do
    stub_data_bag_item('nessus', 'agent').and_return({id: "agent", login: "agent", password: "test", admin: "y" })
    stub_data_bag_item('nessus', 'user').and_return({id: "user", login: "user", password: "test", admin: "n" })
  end
  context 'centos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
      end.converge(described_recipe)
    end

    it 'installs package expect' do
      expect(chef_run).to install_package('expect')
    end
  end
end

