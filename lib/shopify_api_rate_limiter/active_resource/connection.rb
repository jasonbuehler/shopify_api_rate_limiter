require 'shopify_api_rate_limiter/throttled_connection'

module ActiveResource
  class Connection
    prepend ShopifyApiRateLimiter::ThrottledConnection
  end
end
