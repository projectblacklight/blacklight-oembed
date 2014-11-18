module Blacklight::Oembed
  module OembedHelper

    def render_oembed_tag document
      url = document.first(blacklight_config.show.oembed_field)

      return if url.blank?

      send Blacklight::Oembed::Engine.config.render_helper, url
    end

    private
    def render_oembed_tag_embed url
      begin
        OEmbed::Providers.get(url).html.html_safe
      rescue OEmbed::NotFound
        link_to t(:'blacklight_oembed.catalog.view'), url
      end
    end

    def render_oembed_tag_async url
      content_tag :div, "", data: { embed_url: blacklight_oembed_engine.embed_url(url: url) }
    end
  end
end