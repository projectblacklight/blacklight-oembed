require 'blacklight'

module Blacklight
  module Oembed
    class Engine < Rails::Engine
    
      initializer "oembed.initialize" do
        OEmbed::Providers.register_all
      end

      Blacklight::Oembed::Engine.config.render_helper = :render_oembed_tag_async

    end
  end
end
