require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../../test_app_templates", __FILE__)

  def remove_index
    remove_file "public/index.html"
  end

  def run_blacklight_generator
    say_status("warning", "GENERATING BL", :yellow)

    if ENV['BLACKLIGHT_VERSION'] == 'github'
      gem 'blacklight', github: 'projectblacklight/blacklight'
    elsif ENV['BLACKLIGHT_VERSION'].present?
      gem 'blacklight', ENV['BLACKLIGHT_VERSION']
    end

    Bundler.with_clean_env do
      run "bundle update"
    end

    generate 'blacklight:install'
  end

  def run_oembed_install
    generate 'blacklight_oembed:install'
  end

end
