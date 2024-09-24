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
    end
  end
end
