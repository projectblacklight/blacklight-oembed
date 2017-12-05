require 'spec_helper'

describe Blacklight::Oembed::EmbedController do
  routes { Blacklight::Oembed::Engine.routes }
  describe "show" do

    render_views

    before do
      Blacklight::Oembed::Engine.config.render_helper = :render_oembed_tag_embed
      Blacklight::Oembed::Engine.config.additional_params = [:canvas_index]
    end

    let :oembed_obj do
      double(html: "some-markup")
    end

    it "fetches oembed markup for a url" do
      allow(OEmbed::Providers).to receive(:get).with('http://some/uri', {}).and_return oembed_obj
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

    it 'passes along configured additional keys' do
      allow(OEmbed::Providers).to receive(:get).with('http://some/uri', canvas_index: '5').and_return oembed_obj
      get :show, params: { url: 'http://some/uri', canvas_index: '5' }
      expect(response.status).to eq 200
    end
  end
end
