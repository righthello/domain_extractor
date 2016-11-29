require "bundler/gem_tasks"
require 'rake/testtask'
require "tld_updater/runner"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/*_test.rb"
  t.pattern = "test/**/*_test.rb"
end

task default: :test


namespace :tld do
  task :update do
    DomainExtractor::TLDUpdater::Runner.new.call
  end
end
