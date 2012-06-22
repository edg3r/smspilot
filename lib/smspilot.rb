require "smspilot/version"
require 'net/http'
require 'json'

module Smspilot

	GATE_URI = URI("http://smspilot.ru/api2.php")

	class Sender

		def initialize(apikey)
			@apikey = apikey
		end

		def send_sms(sms_id, sms_from, sms_to, message_text)
	    req = Net::HTTP::Post.new(GATE_URI.path, initheader = {'Content-Type' =>'application/json'})
	    req.body = build_request_body(sms_id, sms_from, sms_to, message_text)
      response = Net::HTTP.new(GATE_URI.hostname).start {|http| http.request(req) }
      puts "Response #{response.code} #{response.message}:
      #{response.body}"
 		end

	private 
		
		def build_request_body(sms_id, sms_from, sms_to, message_text)
			{"apikey" => @apikey,
			 "send" => [{"id" => sms_id, "from" => sms_from, "to" => sms_to, "text" => message_text}] 
			 }.to_json
		end
	end
end
