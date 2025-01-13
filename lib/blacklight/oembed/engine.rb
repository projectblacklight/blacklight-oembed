require 'blacklight'

module Blacklight
  module Oembed
    class Engine < Rails::Engine
      # @deprecated
      config.render_helper = :render_oembed_tag_async

      ##
      # Allows an adopter to pass additional parameters through to an OEmbed
      # service. Examples of this could include `:canvas_index`, or `:max_width`
      config.additional_params = []

      initializer 'blacklight_oembed.importmap', before: 'importmap' do |app|
        app.config.assets.paths << Engine.root.join("app/javascript")
        app.config.importmap.paths << Engine.root.join('config/importmap.rb') if app.config.respond_to?(:importmap)
      end
    end
  end
end
