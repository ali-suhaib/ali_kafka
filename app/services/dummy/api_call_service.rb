require "http"

module Dummy
  class ApiCallService
    def initialize(data, token)
      @visits = {visits: data}
      @token = token
      @base_url = dummy_base_url
    end

    def create_visits
      post_request("#{@base_url}/webhooks/dummy_controller")
    end

    def post_request(url)
      request_headers.post( url, json: @visits)
    end

    private

    def request_headers
      HTTP.headers({"Authorization" => "Bearer #{@token}"})
    end

    def dummy_base_url
      "#{ENV['DUMMY_BASE_URL']}"
    end
  end
end
