# Blacklight::Oembed
[![Gem Version](https://badge.fury.io/rb/blacklight-oembed.svg)](http://badge.fury.io/rb/blacklight-oembed)

blacklight-oembed adds [OEmbed](http://oembed.info) displays for Blacklight's search results views.

## Installation

Add this line to your Blacklight application's Gemfile:

    gem 'blacklight-oembed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blacklight-oembed

## Usage

Run the blacklight-oembed generator:

    $ rails g blacklight_oembed:install

The generator will provide reasonable defaults and inject oembed configuration into your `CatalogController`.

In your solr index, you need a field containing the URL to an oembeddable object. `blacklight-oembed` will use that URL to render the oembed viewer on your `catalog#show` page. The name of the field can be configured in your Blacklight configuration:

```
# app/controllers/catalog_controller
class CatalogController
...
    configure_blacklight do |config|
        # these are generated into your configuration by the install generator.
        config.show.oembed_field = :oembed_url_ssm
        config.show.partials.insert(1, :oembed)
    end
...
end
```

In an initializer, you may want to register additional oembed providers for the [`ruby-oembed`](https://github.com/judofyr/ruby-oembed), e.g.:

```
# config/initializers/oembed_providers
require 'oembed'

OEmbed::providers.register_all

purl_provider = OEmbed::Provider.new("http://purl.stanford.edu/embed.{format}?&hide_title=true")
purl_provider << "http://purl.stanford.edu/*"
OEmbed::Providers.register(purl_provider)
```


You need a solr field containing a URL to an embeddable object.

### Additional configurations
Blacklight OEmbed allows for more configurations. In an initializer, you can add additional params that will be passed through to an OEmbed provider.

```
# config/initializers/blacklight_oembed.rb
Blacklight::Oembed::Engine.config.additional_params = [:canvas_index]
```

## Contributing

1. Fork it ( http://github.com/sul-dlss/blacklight-oembed/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
