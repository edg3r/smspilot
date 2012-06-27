require 'smspilot/connection'
require 'smspilot/configuration'
require 'smspilot/request'
require 'json'

module Smspilot
	class Api
		include Connection
		include Request

    attr_accessor *Configuration::VALID_OPTIONS_KEYS

		def initialize options = {}
      options = Smspilot.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def send_sms(sms_id, sms_from, sms_to, message_text)
			json_body = {"apikey" => api_key,
       				"send" => [{"id" => sms_id, "from" => sms_from, "to" => sms_to, "text" => message_text}] 
      				}.to_json    	
    	json_response = send_request json_body

      result = json_response.delete("send")[0]
      result.merge json_response

    rescue Exception => e  
      process_error(e)

    end

    def check_sms_status
    	true
    end

    def check_balance
    	true
    end

		# def initialize(api_key)
		# 	@api_key = api_key
		# end
  private

    def process_error(e)
      #kind_of?
      #TIMEOUT ERRORS
      #API ERRORS
      #INVALID JSON ERRORS
      #RESPONSE STATUS ERRORS


    end

	end
end