# encoding: utf-8

require 'spec_helper'

describe Smspilot do

  let(:sms_id) {'12345'}
  let(:sms_from) {'SMSPILOT'}
  let(:sms_to) {79091112233}
  let(:message_text) {"Тест"}

  let(:json_success) {'JSON
      {    "send": [    
            { "id": "12345",  "server_id": "10005",   "from": "SMSPILOT",   "to": "79091112233",   "text": "Тест",   "zone": "1",   "parts": "1",   "credits": "1",   "status": "0",   "error": "0"    }
          ]
          "server_packet_id": "1234",
          "balance": "10000", }
      '}

  let(:json_failure) {'{   "error": {    "code": "241",   description": "You dont have enough credits"   } }'}

#TODO add specs for sms delivery statuses
#TODO add specs for parameter validations

  describe "#send_sms" do 

    before do
      @sender = Smspilot::Sender.new(:apikey => "XYZ")
    end

    it "should return true when succeeded" do
      stub_request(:post, "http://smspilot.ru/api2.php").to_return(:body => json_success, :status => 200 )
      @sender.send_sms(sms_id, sms_from, sms_to, message_text).should eql(true)
    end
 
    it "should return false if there are errors" do
      stub_request(:post, "http://smspilot.ru/api2.php").to_return(:body => json_success, :status => 200 )
      @sender.send_sms(sms_id, sms_from, sms_to, message_text).should eql(false)
    end

  end

end
