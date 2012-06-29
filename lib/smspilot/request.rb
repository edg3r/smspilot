require 'timeout'
require 'faraday_middleware'
require 'faraday'
require 'smspilot/errors'

module Smspilot
  module Request


# TODO ERRORS CHECK

    def send_request(body)
      json_body = {"apikey" => api_key}.merge(body).to_json
      begin
        response = connection.post do |req|
          req.body = json_body
        end
        
        response_error = (response.status == 200) ? Smspilot::Error::WrongStatusError : nil
        logger.info("send_sms request")

      rescue Exception => e 
        if e.kind_of? Faraday::Error::TimeoutError
          logger.error("TIMEOUT #{e}")     
          response_error = Smspilot::Error::TimeoutError
        elsif e.kind_of? Faraday::Error::ParsingError
          logger.error("PARSING #{e}")     
          response_error = Smspilot::Error::ParsingError      
        end 
      end 

      #apierrors

      unless response.body["error"].nil?
        logger.error("#{response.body["error"]["code"]}")
        #Error::ApiError.raise_by_code(response.body["error"]["code"])
        response_error = Error::ApiError.get_by_code(response.body["error"]["code"]).new()
      end

      #successful
      # def response.error; response_error end
      response.instance_eval <<-RESP
        def error; #{response_error} end
      RESP
      response
    end
  end
end