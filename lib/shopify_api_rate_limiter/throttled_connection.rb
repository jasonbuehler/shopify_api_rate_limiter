module ShopifyApiRateLimiter::ThrottledConnection
  SHOPIFY_SLEEP_TIME = 0.5

  def request(method, path, *arguments)
    if self === ShopifyAPI::Base.connection
      if ShopifyAPI::Base.connection.response && ShopifyAPI.credit_maxed?
        Rails.logger.info "Shopify rate limit credit maxed. Sleeping #{SHOPIFY_SLEEP_TIME}..."
        sleep(SHOPIFY_SLEEP_TIME)
      end
      begin
        super
      rescue ActiveResource::ConnectionError => ex
        if ex.response.code.to_s == '429'
          Rails.logger.info "Shopify returned 429 (Rate Limit Exceeded). Sleeping #{SHOPIFY_SLEEP_TIME}..."
          sleep(SHOPIFY_SLEEP_TIME)
          retry
        else
          raise ex
        end
      end
    else
      super
    end
  rescue ShopifyAPI::Limits::LimitUnavailable => limit_unavailable
    # Either Shopify API stopped sending the limit header, or we're in a stubby test
    super
  end
end
