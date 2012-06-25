module Smspilot
  module Error
    class ClientError < StandardError

    end

    class TimeoutError < ClientError; end;
    class InvalidJsonError < ClientError; end;
    class InvalidResposeStatusError < ClientError; end;
  end
end
