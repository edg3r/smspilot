# encoding: utf-8

require 'spec_helper'
require 'pry'

describe Smspilot do

  let(:sms_id) {'12345'}
  let(:sms_server_id) {'10005'}
  let(:sms_from) {'SMSPILOT'}
  let(:sms_to) {79091112233}
  let(:message_text) {"Тест"}
  let(:json_failure_response) {'{"error":{"code":"1337","description":"leeterror"}}'}


#TODO add specs for sms delivery statuses
#TODO add specs for parameter validations


  before do
    @client = Smspilot.new "XXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZXXXXXXXXXXXXYYYYYYYYYYYYZZZZZZZZ"
  end

  describe "#send_sms" do 
    
    let(:json_send_response) { {"send"=> [{"id"=>"12345", "server_id"=>"10005", "from"=>"SMSPILOT", "to"=>"79091112233", "text"=>"Тест", "zone"=>"1", "parts"=>"1", "credits"=>"1", "status"=>"0", "error"=>"0"}], "server_packet_id"=>"1234", "balance"=>"10000"}.to_json}

    it "should return correct result when succeeded" do
      stub_normal_request(json_send_response)
      result = @client.send_sms(sms_id, sms_from, sms_to, message_text)
      result.body.should == {"send"=> [{"id"=>"12345", "server_id"=>"10005", "from"=>"SMSPILOT", "to"=>"79091112233", "text"=>"Тест", "zone"=>"1", "parts"=>"1", "credits"=>"1", "status"=>"0", "error"=>"0"}], "server_packet_id"=>"1234", "balance"=>"10000"}
      result.status.should eql(200)
    end

  end


  describe "#check_sms_status" do 
    
    let (:check_response_hash) { {"check"=> [{"id"=>"12345", "server_id"=>"10005", "status"=>"1", "modified"=>"2011-08-11 14:35:00"}]} }

    it "should return correct hash when succeeded" do
      stub_normal_request(check_response_hash.to_json)      
      
      result = @client.check_sms_status(sms_server_id)
      result.body.should == {"check"=> [{"id"=>"12345", "server_id"=>"10005", "status"=>"1", "modified"=>"2011-08-11 14:35:00"}]} 
      result.status.should eql(200)    
    end
    it "should return correct sms status when succeeded" do
      check_response_hash["check"].first["status"] = Smspilot::Api::NOT_FOUND_STATUS
      stub_normal_request(check_response_hash.to_json)      
      
      result = @client.check_sms_status(sms_server_id)
      result.not_found?.should be_true
    end
    it "should return correct sms status when succeeded" do
      check_response_hash["check"].first["status"] = Smspilot::Api::NOT_DELIVERED_STATUS
      stub_normal_request(check_response_hash.to_json)      
      
      result = @client.check_sms_status(sms_server_id)
      result.not_delivered?.should be_true   
    end
    it "should return correct sms status when succeeded" do
      check_response_hash["check"].first["status"] = Smspilot::Api::ACCEPTED_STATUS
      stub_normal_request(check_response_hash.to_json)      
      
      result = @client.check_sms_status(sms_server_id)
      result.accepted?.should be_true   
    end
    it "should return correct sms status when succeeded" do
      check_response_hash["check"].first["status"] = Smspilot::Api::AT_OPERATOR_STATUS
      stub_normal_request(check_response_hash.to_json)      
      
      result = @client.check_sms_status(sms_server_id)
      result.at_operator?.should be_true   
    end
    it "should return correct sms status when succeeded" do
      check_response_hash["check"].first["status"] = Smspilot::Api::DELIVERED_STATUS
      stub_normal_request(check_response_hash.to_json)      
      
      result = @client.check_sms_status(sms_server_id)
      result.delivered?.should be_true   
    end

  end

  describe "#check_balance" do 
    
    let(:json_balance_response) {'{"balance":31337}'}

    it "should return correct hash when succeeded" do
      stub_normal_request(json_balance_response)
      
      result = @client.check_balance
      result.body.should == {"balance"=> 31337} 
      result.status.should eql(200)    
    end

  end

  describe "send_request errors" do

    before do
      stub_normal_request(json_failure_response)
    end

    it "should be unknown apierror when there is correct error response" do
      result = @client.send_request({})
      result.error.should eql(Smspilot::Error::UnknownApiError)
    end 

    it "should be correct apierror type when there is correct error response" do
      Smspilot::Error::API_ERROR_CODES["1337"] = "LeetError"
      class Smspilot::Error::LeetError < Smspilot::Error::ApiError; end    
      
      result = @client.send_request({})
      result.error.should eql(Smspilot::Error::LeetError)
    end 

  end

end
