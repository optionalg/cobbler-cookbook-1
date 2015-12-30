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

describe file('/var/lib/cobbler/kickstarts/kickstart.cfg') do
  it { should be_owned_by('root') }
end

describe command('cobbler repo report --name epel') do
  its(:exit_status) { should eq 0 }
end

describe command('cobbler distro report --name sampledistro')  do
  its(:exit_status) { should eq 0 }
end

describe command('cobbler profile report --name sampleprofile') do
  its(:exit_status) { should eq 0 }
end
