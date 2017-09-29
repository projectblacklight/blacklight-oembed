# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blacklight/oembed/version'

Gem::Specification.new do |spec|
  spec.name          = "blacklight-oembed"
  spec.version       = Blacklight::Oembed::VERSION
  spec.authors       = ["Chris Beer"]
  spec.email         = ["cabeer@stanford.edu"]
  spec.summary       = %q{Oembed display for Blacklight}
  spec.homepage      = "https://github.com/sul-dlss/blacklight-oembed"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "blacklight", ">= 5.0", "< 7"
  spec.add_dependency "bootstrap-sass", "~> 3.0"
  spec.add_dependency "ruby-oembed"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails", "~> 3.1"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-activemodel-mocks"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "solr_wrapper"
  spec.add_development_dependency "engine_cart", "~> 0.8"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "poltergeist", ">= 1.5.0"
end
