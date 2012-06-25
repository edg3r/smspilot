require "smspilot/client"
require "smspilot/configuration"

module Smspilot

  extend Configuration

  class << self
    def new options = {}
      if options.is_a? String
        Smspilot::Client.new :api_key => options
      elsif options.is_a? Hash
        Smspilot::Client.new options
      else
        raise ArgumentError
      end
    end
  end

end
