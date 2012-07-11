require 'faraday_middleware'


module Smspilot
  module Connection
    private

      def connection
        options = {
          :headers => {
            :user_agent => user_agent
          },
          :url => endpoint,
          :timeout => timeout,
          :open_timeout => timeout
        }

        Faraday.new options do |conn|
          # conn.request :url_encoded
          conn.request :json

          conn.response :json
          conn.response :mashify
          conn.response :logger

          conn.adapter(adapter)
        end
      end
  end
end