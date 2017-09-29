require "bundler/gem_tasks"

APP_ROOT = File.dirname(__FILE__)

require 'rspec/core/rake_task'
require 'engine_cart/rake_task'
require 'solr_wrapper'

task :default => :ci

desc "Run specs"
RSpec::Core::RakeTask.new do |t|

end

desc "Load fixtures"
task :fixtures => ['engine_cart:generate'] do
  within_test_app do
      system "rake blacklight:index:seed RAILS_ENV=test"
      abort "Error running fixtures" unless $?.success?
  end
end

desc "Execute Continuous Integration build"
task ci: 'engine_cart:generate' do

  ENV['environment'] = "test"
  SolrWrapper.wrap(port: '8983') do |solr|
    solr.with_collection(name: 'blacklight-core', dir: File.join(File.expand_path(File.dirname(__FILE__)), 'solr', 'conf')) do
      Rake::Task['fixtures'].invoke
      Rake::Task['spec'].invoke
    end
  end
end

task :server do
  if File.exists? 'spec/internal'
    within_test_app do
      system "bundle update"
    end
  else
    Rake::Task['engine_cart:generate'].invoke
  end

  SolrWrapper.wrap(port: '8983')  do
    within_test_app do
      system "rake blacklight:index:seed"
      system "bundle exec rails s"
    end
  end
end
