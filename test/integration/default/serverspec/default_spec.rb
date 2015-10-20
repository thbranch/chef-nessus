require_relative 'spec_helper'

describe package('Nessus') do
  it { should be_installed }
end

describe service('nessusd') do
  it { should be_enabled }
  it { should be_running }
end

describe package('expect') do
  it { should be_installed }
end

describe port(8834) do
  it { should be_listening }
end
