import oembed from 'blacklight_oembed/oembed'

Blacklight.onLoad(function() {
  oembed(document.querySelectorAll('[data-embed-url]'));
});
