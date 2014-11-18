require 'spec_helper'

describe Blacklight::Oembed::OembedHelper do
  before :all do
    @original_value = Blacklight::Oembed::Engine.config.render_helper
  end

  after :all do
    Blacklight::Oembed::Engine.config.render_helper = @original_value
  end

  let :document do
    SolrDocument.new
  end

  let :blacklight_config do
    Blacklight::Configuration.new do |config|
      config.show.oembed_field = :oembed_url_ssm
    end
  end

  before do
    allow(helper).to receive(:blacklight_config).and_return(blacklight_config)
  end

  it "should render nothing if no oembed url is available" do
    expect(helper.render_oembed_solr_document_tag(document)).to be_blank
  end

  describe "async" do
    before do
      Blacklight::Oembed::Engine.config.render_helper = :render_oembed_tag_async
    end

    let :document do
      SolrDocument.new oembed_url_ssm: 'http://some/uri'
    end

    it "should render a placeholder for oembed data" do
      rendered = helper.render_oembed_solr_document_tag document
      expect(rendered).to have_css "[data-embed-url]"
      expect(rendered).to have_css "[data-embed-url='#{blacklight_oembed_engine.embed_url(url: "http://some/uri")}']"
    end
  end

  describe "embed" do
    before do
      Blacklight::Oembed::Engine.config.render_helper = :render_oembed_tag_embed
    end

    let :document do
      SolrDocument.new oembed_url_ssm: 'http://some/uri'
    end

    let :oembed_obj do
      double(html: "some-markup")
    end

    it "should fetch oembed markup for a url" do
      allow(OEmbed::Providers).to receive(:get).with('http://some/uri').and_return oembed_obj
      rendered = helper.render_oembed_solr_document_tag document
      expect(rendered).to eq "some-markup"
    end

    it "should gracefully fail to a view link" do
      rendered = helper.render_oembed_solr_document_tag document
      expect(rendered).to have_link "View", href: "http://some/uri"
    end
  end
end