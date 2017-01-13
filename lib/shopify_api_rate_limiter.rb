module ShopifyApiRateLimiter
  class << self
    attr_accessor :logger
  end

  class Railties < ::Rails::Railtie
    initializer 'Rails logger' do
      ShopifyApiRateLimiter.logger = Rails.logger
    end
  end

  if defined?(Rails)
    require 'shopify_api_rate_limiter/active_resource/connection'
    require 'shopify_api_rate_limiter/throttled_connection'
    require 'shopify_api_rate_limiter/engine'
  else
    require 'shopify_api_rate_limiter/active_resource/connection'
    require 'shopify_api_rate_limiter/throttled_connection'
  end
end
