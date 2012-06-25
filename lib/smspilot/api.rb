require 'smspilot/connection'
require 'smspilot/configuration'
require 'smspilot/request'

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
    	true
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




	# 	def send_sms(sms_id, sms_from, sms_to, message_text)
	#     req = Net::HTTP::Post.new(GATE_URI.path, initheader = {'Content-Type' =>'application/json'})
	#     req.body = build_request_body(sms_id, sms_from, sms_to, message_text)
 #      response = Net::HTTP.new(GATE_URI.hostname).start {|http| http.request(req) }
 #      # puts "Response #{response.code} #{response.message}:
 #      # #{response.body}"

 #      json = JSON.parse(response.body)
 #      puts json
 #      puts "ERRORS" if json.has_key? 'error'
 # 		end


	# private
		
	# 	def build_request_body(sms_id, sms_from, sms_to, message_text)
	# 		{"apikey" => @apikey,
	# 		 "send" => [{"id" => sms_id, "from" => sms_from, "to" => sms_to, "text" => message_text}] 
	# 		 }.to_json
	# 	end
	end
end