# -*- encoding: utf-8 -*-
require File.expand_path("../lib/shopify_api_rate_limiter/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'shopify_api_rate_limiter'
  s.version     = ShopifyApiRateLimiter::VERSION 
  s.date        = '2017-01-11'
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Rate limits API requests to the Shopify API."
  s.description = "A simple (hacky) solution for rate limiting API requests to the Shopify API."
  s.authors     = ["Jason Buehler"]
  s.email       = 'jason.c.buehler@gmail.com'
  s.files       = `git ls-files`.split("\n")

  s.homepage    = 'http://rubygems.org/gems/shopify_api_rate_limiter'
  s.license     = 'MIT'

  s.add_runtime_dependency "shopify_api", ">= 1.2.2"
	s.add_development_dependency "bundler", ">= 1.0.0"
	s.require_path = 'lib'
end
