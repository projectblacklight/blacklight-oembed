require 'blacklight/oembed/version'
require 'oembed'
module Blacklight
  module Oembed
    def self.deprecator
      @deprecator ||= ActiveSupport::Deprecation.new('2.0.0', 'blacklight-oembed')
    end

    require 'blacklight/oembed/engine'
  end
end
