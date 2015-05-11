# encoding: UTF-8
require 'chefspec'
require 'chefspec/berkshelf'
require 'yarjuf'

ChefSpec::Coverage.start!

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.platform = 'centos'
  config.version = '6.5'
end
