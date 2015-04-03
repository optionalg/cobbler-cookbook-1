# encoding: UTF-8
require 'spec_helper'

describe 'alti_skeleton::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new do # |node|
    end.converge(described_recipe)
  end

  it 'does not start a weird unexpected service' do
    expect(chef_run).to_not start_service('weird_unexpected_service')
  end
end
