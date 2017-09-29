require 'spec_helper'

describe Blacklight::Oembed::EmbedController do
  routes { Blacklight::Oembed::Engine.routes }
  describe "show" do

    render_views

    before do
      Blacklight::Oembed::Engine.config.render_helper = :render_oembed_tag_embed
    end

    let :oembed_obj do
      double(html: "some-markup")
    end

    it "fetches oembed markup for a url" do
      allow(OEmbed::Providers).to receive(:get).with('http://some/uri').and_return oembed_obj
      get :show, params: { url: 'http://some/uri' }
      json = JSON.parse(response.body)
      expect(json["html"]).to eq "some-markup"
    end

    it "gracefully fails to a view link" do
      get :show, params: { url: 'http://some/uri' }
      expect(response.status).to eq 400
      json = JSON.parse(response.body)
      expect(json["html"]).to be_blank
    end
  end
end
