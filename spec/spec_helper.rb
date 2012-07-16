require 'rspec'
require 'webmock/rspec'
require 'smspilot'
require 'smspilot/errors'
require 'pry'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

def stub_normal_request(body)
  stub_request(:post, Smspilot::Configuration::DEFAULT_ENDPOINT).to_return(:body => body, :status => 200, :headers => {:content_type => 'application/json'} )      
end