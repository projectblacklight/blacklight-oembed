require 'spec_helper'

RSpec.describe 'Embed', type: :feature do
  before do
    CatalogController.blacklight_config.show.oembed_field = :id
  end

  it 'embeds the widget on the show page' do
    visit '/catalog/2007020969'

    expect(page).to have_css '.oembed-widget'

    embed_div = find('.oembed-widget div')

    expect(embed_div['data-async-embed-url']).to include '/oembed/embed?url=2007020969'
  end
end
