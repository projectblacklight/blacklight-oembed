module Blacklight
  module Oembed
    class DocumentOembedComponent < Blacklight::Component
      attr_reader :document, :presenter, :classes

      def initialize(document:, presenter:, classes: ['oembed-widget'], **kwargs)
        super

        @document = document
        @presenter = presenter
        @classes = classes
      end

      def embed
        return if embed_url.blank?

        @embed ||= if Blacklight::Oembed::Engine.config.render_helper != :render_oembed_tag_async && Blacklight::Oembed::Engine.config.render_helper != :render_oembed_tag_embed
                     legacy_helper_method_embed_markup
                   elsif view_config.render_oembed_using_async_javascript || Blacklight::Oembed::Engine.config.render_helper == :render_oembed_tag_async
                     async_embed_markup
                   else
                     inline_embed_markup
                   end
      end

      def render?
        embed.present?
      end

      private

      def view_config
        presenter.view_config
      end

      def embed_url
        document.first(view_config.oembed_field)
      end

      def async_embed_url(**kwargs)
        helpers.blacklight_oembed_engine.embed_url(**kwargs)
      end

      def async_embed_markup
        content_tag :div, '', data: { async_embed_url: async_embed_url(url: embed_url) }
      end

      def inline_embed_markup
        OEmbed::Providers.get(embed_url).html.html_safe
      rescue OEmbed::NotFound
        link_to t(:'blacklight_oembed.catalog.view'), embed_url
      end

      def legacy_helper_method_embed_markup
        Blacklight::Oembed.deprecator.warn('Subclass Blacklight::Oembed::DocumentOembedComponent instead of using the blacklight-oembed render_helper config')
        helpers.call(Blacklight::Oembed::Engine.config.render_helper, url)
      end
    end
  end
end
