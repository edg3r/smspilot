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
      body = {"send" => [{"id" => sms_id.to_s, "from" => sms_from.to_s, "to" => sms_to.to_s, "text" => message_text.to_s}]}     
      send_request body
    end

    def check_sms_status (sms_server_id)
      body = {"check" => [{"server_id" => sms_server_id}]}
      send_request body
    end

    def check_balance
      body = {"balance" => [{"balance" => true}]}
      send_request body
    end


    def send_sms!(sms_id, sms_from, sms_to, message_text)
      response = send_sms(sms_id, sms_from, sms_to, message_text)
      raise response.error if response.error.kind_of? StandardError
      response
    end

    def check_sms_status! (sms_server_id)
      response = check_sms_status (sms_server_id)
      raise response.error if response.error.kind_of? StandardError
      response  
    end

    def check_balance!
      response = check_balance
      raise response.error if response.error.kind_of? StandardError
      response
    end

		# def initialize(api_key)
		# 	@api_key = api_key
		# end
 end
end