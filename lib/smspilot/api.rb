require 'smspilot/connection'
require 'smspilot/configuration'
require 'smspilot/request'
require 'smspilot/errors'
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
    	response = send_request json_body
    end

    def check_sms_status (sms_server_id)
      json_body = {"apikey" => api_key,
              "check" => [{"server_id" => sms_server_id}] 
              }.to_json     
      response = send_request json_body
    end

    def check_balance
      json_body = {"apikey" => api_key,
              "balance" => [{"balance" => true}] 
              }.to_json     
      response = send_request json_body
    end

		# def initialize(api_key)
		# 	@api_key = api_key
		# end
 end
end