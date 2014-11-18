require 'blacklight'

module Blacklight
  module Oembed
    class Engine < Rails::Engine

      Blacklight::Oembed::Engine.config.render_helper = :render_oembed_tag_async

    end
  end
end
