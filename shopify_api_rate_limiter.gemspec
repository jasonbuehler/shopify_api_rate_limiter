Gem::Specification.new do |s|
  s.name        = 'shopify_api_rate_limiter'
  s.version     = '0.0.0'
  s.date        = '2017-01-11'
  s.summary     = "Rate limits API requests to the Shopify API."
  s.description = "A simple solution for rate limiting API requests to the Shopify API."
  s.authors     = ["Jason Buehler"]
  s.email       = 'jason.c.buehler@gmail.com'
  s.files       = ["lib/shopify_api_rate_limiter.rb", "lib/shopify_api_rate_limiter/throttled_connection.rb"]
  s.homepage    =
    'http://rubygems.org/gems/shopify_api_rate_limiter'
  s.license       = 'MIT'

	s.add_runtime_dependency 'activeresource', '>= 3.0.0'
end
