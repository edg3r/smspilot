require 'faraday_middleware'


module Smspilot
  module Connection
    private

      def connection
        options = {
          :url => endpoint,
          :headers => {
            :user_agent => user_agent
          },
          :request => {
            :timeout => timeout,
            :open_timeout => timeout
          }
        }

        Faraday.new options do |conn|
          conn.request :json

          conn.response :json
          conn.response :mashify
          conn.response :logger, logger

          conn.adapter(adapter)
        end
      end
  end
end
