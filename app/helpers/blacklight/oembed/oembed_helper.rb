module Blacklight::Oembed
  module OembedHelper
    # @deprecated
    def render_oembed_solr_document_tag(document)
      url = document.first(blacklight_config.show.oembed_field)
      return if url.blank?

      render_oembed_tag url
    end

    # @deprecated
    def render_oembed_tag(url)
      send Blacklight::Oembed::Engine.config.render_helper, url
    end
    Blacklight::Oembed.deprecator.deprecate_methods Blacklight::Oembed::OembedHelper,
                                                    :render_oembed_solr_document_tag, :render_oembed_tag,
                                                    'Use Blacklight::Oembed::DocumentOembedComponent instead'

    private

    def render_oembed_tag_embed(url)
      OEmbed::Providers.get(url).html.html_safe
    rescue OEmbed::NotFound
      link_to t(:'blacklight_oembed.catalog.view'), url
    end

    def render_oembed_tag_async(url)
      content_tag :div, '', data: { embed_url: blacklight_oembed_engine.embed_url(url: url) }
    end
  end
end
