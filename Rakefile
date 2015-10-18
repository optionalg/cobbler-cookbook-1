# encoding: UTF-8
require 'bundler/setup'
require 'English'

# Style tests. Rubocop and Foodcritic
namespace :style do
  require 'rubocop/rake_task'
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  require 'foodcritic'
  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any'],
      tags: [
        '~FC007'
      ]
    }
  end
end

namespace :alti do
  desc 'Attempt a berks install or update'
  task :berks do
    unless ENV['BERKSHELF_CONFIG'] && File.exist?(ENV['BERKSHELF_CONFIG'])
      puts 'No Chef environment configured'
      exit false
    end
    puts `berks install || berks update`
    exit false unless $CHILD_STATUS == 0
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# Rspec and ChefSpec
require 'rspec/core/rake_task'
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '-f documentation -f progress -f JUnit -o results.xml'
end

require 'kitchen'
desc 'Run Test Kitchen integration tests'
task :integration do
  Kitchen.logger = Kitchen.default_file_logger
  Kitchen::Config.new.instances.each do |instance|
    instance.test(:always)
  end
end

# The default rake task should just run it all
task default: %w(spec style alti:berks integration)
