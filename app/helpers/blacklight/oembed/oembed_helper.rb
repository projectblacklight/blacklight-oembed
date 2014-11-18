module Blacklight::Oembed
  module OembedHelper
    def render_oembed_tag document
      url = document.first(blacklight_config.show.oembed_field)

      return if url.blank?

      begin
        OEmbed::Providers.get(url).html.html_safe
      rescue OEmbed::NotFound
        link_to t(:'blacklight_oembed.catalog.view'), url
      end
    end
  end
end