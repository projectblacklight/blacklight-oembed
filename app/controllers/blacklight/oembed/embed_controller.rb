module Blacklight::Oembed
  class EmbedController < ActionController::Metal 
    def show
      self.content_type  = "application/json"
      self.response_body = { html: get_embed_content(params[:url]) }.to_json
    end

    private

    def get_embed_content url
      begin
        OEmbed::Providers.get(url).html.html_safe
      rescue OEmbed::NotFound
        self.status = 400
        ""
      end
    end
  end
end