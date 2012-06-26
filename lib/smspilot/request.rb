require 'timeout'
require 'faraday_middleware'
require 'faraday'

module Smspilot
  module Request

# TODO ERROES CHECK

    def send_request(json_body)
      response = connection.post do |req|
        req.body = json_body
      end

      #successful
      json_response = JSON.parse(response.body)
      result = json_response.delete("send")[0]
      result.merge json_response

    end



  #   def send_sms(sms_id, sms_from, sms_to, message_text)
  #     req = Net::HTTP::Post.new(GATE_URI.path, initheader = {'Content-Type' =>'application/json'})
  #     req.body = build_request_body(sms_id, sms_from, sms_to, message_text)
 #      response = Net::HTTP.new(GATE_URI.hostname).start {|http| http.request(req) }
 #      # puts "Response #{response.code} #{response.message}:
 #      # #{response.body}"

 #      json = JSON.parse(response.body)
 #      puts json
 #      puts "ERRORS" if json.has_key? 'error'
 #    end


  # private
    
  #   def build_request_body(sms_id, sms_from, sms_to, message_text)
  #     {"apikey" => @apikey,
  #      "send" => [{"id" => sms_id, "from" => sms_from, "to" => sms_to, "text" => message_text}] 
  #      }.to_json
  #   end    
    # def get path, options = {}
    #   request(:get, path, options)
    # end

    # def post path, options = {}
    #   request(:post, path, options)
    # end

    # def put(path, options = {})
    #   request(:put, path, options)
    # end

    # def delete(path, options = {})
    #   request(:delete, path, options)
    # end

    # private

    #   def request(method, path, options)

    #     options = options.merge access_token: access_token

    #     response = Timeout.timeout(timeout) do
    #       connection.send(method) do |request|
    #         case method.to_sym
    #         when :get, :delete
    #           request.url path, options
    #         when :post, :put
    #           request.path = path
    #           request.body = options unless options.empty?
    #         end
    #       end
    #     end
    #     enchant response
    #   rescue Timeout::Error
    #     Class.new { extend TimeoutErrorHelper::ClassMethods }
    #   rescue MultiJson::DecodeError
    #     Class.new { extend JsonErrorHelper::ClassMethods }
    #   end

    #   def enchant response
    #     if response.status == 200
    #       def response.ok?; true end
    #       def response.error_message; nil end

    #     else
    #       def response.ok?; false end
    #       def response.error_message; "Status not 200" end

    #     end

    #     response
    #   end



  end
end