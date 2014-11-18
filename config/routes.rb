Blacklight::Oembed::Engine.routes.draw do
  get 'embed' => 'blacklight/oembed/embed#show', as: 'embed'
end