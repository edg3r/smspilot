require 'timeout'
require 'faraday_middleware'
require 'faraday'
require 'smspilot/errors'

module Smspilot
  module Request

    def send_request(body)
      json_body = request_json body
      begin
        response = connection.post do |req|
          req.body = json_body
          logger.info("--------\n" + req.body)
        end

        response_error = (response.status == 200) ? Smspilot::Error::WrongStatusError : nil

      rescue Exception => e
        if e.kind_of? Faraday::Error::TimeoutError
          response_error = Smspilot::Error::TimeoutError
        elsif e.kind_of? Faraday::Error::ParsingError
          response_error = Smspilot::Error::ParsingError
        end
      end

      unless response.body["error"].nil?
        response_error = Error::ApiError.get_by_code(response.body["error"]["code"]).new()
      end

      response.instance_eval <<-RESP
        def error; #{response_error} end
      RESP

      response
    end

    def request_json body
      if login.nil?
       {"apikey" => api_key}.merge(body).to_json
      else
        {"apikey" => api_key, "login" => login, "password" => password}.merge(body).to_json
      end
    end
  end
end