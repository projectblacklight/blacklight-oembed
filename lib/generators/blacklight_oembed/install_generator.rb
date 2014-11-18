require 'rails/generators'

module BlacklightOembed
  class Install < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def assets
      copy_file "blacklight_oembed.css.scss", "app/assets/stylesheets/blacklight_oembed.css.scss"
      copy_file "blacklight_oembed.js", "app/assets/javascripts/blacklight_oembed.js"
    end

    def inject_routes
      route "mount Blacklight::Oembed::Engine, at: 'oembed'"
    end

    def inject_oembed_configuration
      copy_file "oembed_providers.rb", "config/initializers/oembed_providers.rb"
    end

    def configuration
      inject_into_file 'app/controllers/catalog_controller.rb', after: "configure_blacklight do |config|" do
        <<-EOF

          config.show.oembed_field = :oembed_url_ssm
          config.show.partials.insert(1, :oembed)
        EOF
      end
    end
  end
end
