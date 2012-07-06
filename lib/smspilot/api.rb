require 'smspilot/connection'
require 'smspilot/configuration'
require 'smspilot/request'
require 'smspilot/errors'
require 'json'

module Smspilot
  class Api
    include Connection
    include Request

    NOT_FOUND_STATUS = -2
    NOT_DELIVERED_STATUS = -1
    ACCEPTED_STATUS = 0
    AT_OPERATOR_STATUS = 1
    DELIVERED_STATUS = 2    

    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize options = {}
      options = Smspilot.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def send_sms(sms_id, sms_from, sms_to, message_text)
      body = {"send" => [{"id" => sms_id.to_s, "from" => sms_from.to_s, "to" => sms_to.to_s, "text" => message_text.to_s}]}     
      response = send_request body
      enhance_response(response, "send")
    end

    def check_sms_status(sms_server_id)
      body = {"check" => [{"server_id" => sms_server_id}]}
      response = send_request body
      enhance_response(response, "check")
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

  private
    def enhance_response(response, request_type)
      unless response.error
        response.instance_eval <<-RESP
          def not_found?; #{response.body[request_type].first["status"].to_i.eql? NOT_FOUND_STATUS} end
          def not_delivered?; #{response.body[request_type].first["status"].to_i.eql? NOT_DELIVERED_STATUS} end
          def accepted?; #{response.body[request_type].first["status"].to_i.eql? ACCEPTED_STATUS} end
          def at_operator?; #{response.body[request_type].first["status"].to_i.eql? AT_OPERATOR_STATUS} end
          def delivered?; #{response.body[request_type].first["status"].to_i.eql? DELIVERED_STATUS} end
        RESP
      end

      response
    end
 end
end