require 'serverspec'

set :backend, :exec

RSpec.configure do |c|
 c.before :all do
  c.path = '/bin:/usr/bin:/sbin:/usr/sbin'
 end
end
