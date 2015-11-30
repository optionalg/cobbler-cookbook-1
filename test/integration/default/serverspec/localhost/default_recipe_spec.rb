require 'spec_helper'

describe service('weird_unexpected_service') do
  it { should_not be_running }
end
