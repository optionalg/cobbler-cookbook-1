def vcc_chef(name, version = '>= 0.0.0', options = {})
  cookbook(name, version, {
    git: 'git@github.com:VertiCloud/chef.git',
    rel: "cookbooks/local/#{name}",
    protocol: :ssh
  }.merge(options))
end

def verticloud(name, version = '>= 0.0.0', options = {})
  options[:repo] ||= name
  cookbook(name, version, {
    git: "git@github.com:VertiCloud/#{options[:repo]}-cookbook.git",
    protocol: :ssh
  }.merge(options))
end

def altiscale(name, version = '>= 0.0.0', options = {})
  options[:repo] ||= name
  cookbook(name, version, {
    git: "git@github.com:Altiscale/#{options[:repo]}.git",
    protocol: :ssh
  }.merge(options))
end

source 'http://api.berkshelf.com'

metadata
