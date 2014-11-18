require 'blacklight'

module Blacklight
  module Oembed
    class Engine < Rails::Engine
    
      initializer "oembed.initialize" do
        OEmbed::Providers.register_all
      end

    end
  end
end
