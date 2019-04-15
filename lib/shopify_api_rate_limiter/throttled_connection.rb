module ShopifyApiRateLimiter
  class DailySkuLimitError < StandardError ; end

  module ThrottledConnection
    SHOPIFY_SLEEP_TIME = (ENV['SHOPIFY_API_RATE_LIMITER_TIMEOUT'] || 0.5).to_f

    def request(method, path, *arguments)
      if self === ShopifyAPI::Base.connection
        if ShopifyAPI::Base.connection.response && ShopifyAPI.credit_maxed?
          ShopifyApiRateLimiter.logger.info "Shopify rate limit credit maxed. Sleeping #{SHOPIFY_SLEEP_TIME}..."
          sleep(SHOPIFY_SLEEP_TIME)
        end
        begin
          super
        rescue ActiveResource::ClientError => ex
          if ex.response.body == '{"errors":{"product":["Daily SKU limit reached. Please try again later."]}}'
            raise ShopifyApiRateLimiter::DailySkuLimitError, "Daily Sku Limit Reached for Shopify Admin API"
          elsif ex&.response&.code&.to_s == '429'
            ShopifyApiRateLimiter.logger.info "Shopify returned 429 (Rate Limit Exceeded). Sleeping #{SHOPIFY_SLEEP_TIME}..."
            sleep(SHOPIFY_SLEEP_TIME)
            retry
          else
            raise ex
          end
        end
      else
        super
      end
    rescue ShopifyAPI::Limits::LimitUnavailable => _ 
      # Either Shopify API stopped sending the limit header, or we're in a stubby test
      super
    end
  end
end
