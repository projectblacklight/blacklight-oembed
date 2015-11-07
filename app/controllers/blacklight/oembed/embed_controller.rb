module Blacklight::Oembed
  class EmbedController < ActionController::Base

    def show
      render json: { html: get_embed_content(params[:url]) }
    end

    private

    def get_embed_content url
      begin
        OEmbed::Providers.get(url).html.html_safe
      rescue OEmbed::NotFound
        response.status = 400
        ""
      end
    end
  end
end