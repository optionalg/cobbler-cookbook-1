require 'spec_helper'

describe service('cobblerd') do
  it { should be_running }
end

describe service('xinetd') do
  it { should be_running }
end

describe service('httpd') do
  it { should be_running }
end