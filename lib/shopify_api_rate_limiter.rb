module ShopifyApiRateLimiter
  if defined?(Rails)
    require 'shopify_api_rate_limiter/engine'
  else
    require 'shopify_api_rate_limiter/throttled_connection'
  end
end

module ActiveResource
  class Connection
    prepend ShopifyApiRateLimiter::ThrottledConnection
  end
end
