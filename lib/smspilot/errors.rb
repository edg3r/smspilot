module Smspilot
  module Error

    API_ERROR_CODES = {
      "10" => "InputDataRequiredError",
      "11" => "UnknownInputFormatError",
      "12" => "InvalidJsonError",
      "14" => "UnknownCommandError",
      "100" => "ApiKeyRequired",
      "101" => "ApiKeyInvalid",
      "106" => "ApiKeyBlocked",
      "110" => "SystemError",
      "113" => "IpRestrictionError",
      "201" => "FromInvalidError",
      "202" => "FromDeprecatedError",
      "210" => "ToRequiredError",
      "211" => "ToInvalidError",
      "212" => "ToDeprecatedError",
      "213" => "UnsupportedZoneError",
      "220" => "TextRequiredError",
      "221" => "TextTooLongError",
      "230" => "IdInvalidError",
      "231" => "PacketIdInvalidError",
      "240" => "InputListInvalidError",
      "241" => "NotEnoughCreditsError",
      "242" => "SmsCountLimitError",
      "300" => "ServerIdRequiredError",
      "301" => "ServerIdInvalidError",
      "302" => "ServerIdNotFoundError",
      "303" => "InvalidSmsCheckListError",
      "304" => "ServerPacketIdInvalidError",
      "400" => "UserNotFoundError"
    }

    class ApiError < StandardError

      def self.raise_by_code(code=nil)
        if API_ERROR_CODES[code].nil?
          raise UnknownApiError
        else
          raise Smspilot::Error.const_get(API_ERROR_CODES[code])
        end
      end

      def self.get_by_code(code=nil)
        if API_ERROR_CODES[code].nil?
          UnknownApiError
        else
          Smspilot::Error.const_get(API_ERROR_CODES[code])
        end
      end
    end


    class InputDataRequiredError < ApiError; end # 10
    class UnknownInputFormatError < ApiError; end # 11
    class InvalidJsonError < ApiError; end # 12
    class UnknownCommandError < ApiError; end # 14
    class ApiKeyRequired < ApiError; end # 100
    class ApiKeyInvalid < ApiError; end # 101
    class ApiKeyBlocked < ApiError; end # 106
    class SystemError < ApiError; end # 110
    class IpRestrictionError < ApiError; end # 113
    class FromInvalidError < ApiError; end # 201
    class FromDeprecatedError < ApiError; end # 202
    class ToRequiredError < ApiError; end # 210
    class ToInvalidError < ApiError; end # 211
    class ToDeprecatedError < ApiError; end # 212
    class UnsupportedZoneError < ApiError; end # 213
    class TextRequiredError < ApiError; end # 220
    class TextTooLongError < ApiError; end # 221
    class IdInvalidError < ApiError; end # 230
    class PacketIdInvalidError < ApiError; end # 231
    class InputListInvalidError < ApiError; end # 240
    class NotEnoughCreditsError < ApiError; end # 241
    class SmsCountLimitError < ApiError; end # 242
    class ServerIdRequiredError < ApiError; end # 300
    class ServerIdInvalidError < ApiError; end # 301
    class ServerIdNotFoundError < ApiError; end # 302
    class InvalidSmsCheckListError < ApiError; end # 303
    class ServerPacketIdInvalidError < ApiError; end # 304
    class UserNotFoundError < ApiError; end # 400
    class UnknownApiError < ApiError; end # unknown codes
    class TimeoutError < StandardError; end;
    class InvalidJsonResponseError < StandardError; end;
    class InvalidResposeStatusError < StandardError; end;
    class ParsingError < StandardError; end;
  end
end
