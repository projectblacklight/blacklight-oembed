require 'bundler/gem_tasks'

APP_ROOT = File.dirname(__FILE__)

require 'rspec/core/rake_task'
require 'engine_cart/rake_task'
require 'solr_wrapper'
require 'open3'

def system_with_error_handling(*args)
  Open3.popen3(*args) do |_stdin, stdout, stderr, thread|
    puts stdout.read
    raise "Unable to run #{args.inspect}: #{stderr.read}" unless thread.value.success?
  end
end

def with_solr(&block)
  # We're being invoked by the app entrypoint script and solr is already up via docker compose
  if ENV['SOLR_ENV'] == 'docker-compose'
    yield
  elsif system('docker compose version')
    # We're not running `docker compose up' but still want to use a docker instance of solr.
    begin
      puts 'Starting Solr'
      system_with_error_handling 'docker compose up -d solr'
      yield
    ensure
      puts 'Stopping Solr'
      system_with_error_handling 'docker compose stop solr'
    end
  else
    SolrWrapper.wrap do |solr|
      solr.with_collection(&block)
    end
  end
end

task default: :ci

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
end

desc 'Load fixtures'
task fixtures: ['engine_cart:generate'] do
  within_test_app do
    system 'rake blacklight:index:seed RAILS_ENV=test'
    abort 'Error running fixtures' unless $?.success?
  end
end

desc 'Execute Continuous Integration build'
task :ci do
  ENV['environment'] = 'test'
  with_solr do
    Rake::Task['fixtures'].invoke
    Rake::Task['spec'].invoke
  end
end

task :server do
  if File.exist? 'spec/internal'
    within_test_app do
      system 'bundle update'
    end
  else
    Rake::Task['engine_cart:generate'].invoke
  end

  with_solr do
    within_test_app do
      system 'rake blacklight:index:seed'
      system 'bundle exec rails s'
    end
  end
end
