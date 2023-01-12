require "#{Rails.root}/lib/dummy.rb" #doesnot support imports by default

class KafkaConsumer
  include Phobos::Handler

  def consume(payload, metadata)
    test_payload_data= [payload.with_indifferent_access]
    parsed_data = parse_data(test_payload_data)
    @integrated_hotels = Rev1DB.integrated_hotels(parsed_data.keys)
    @integrated_hotels.each do |hotel|
      token = Rev1DB.api_token(hotel[0])
      create_record(parsed_data[hotel[1].to_s], token) if token
    end
  end

  def test_payload_data
    [
      {
        # dummy data here
      }
    ]
  end

  def create_record(payload, token)
    Dummy::ApiCallService.new(payload, token).create_record
  end

  def parse_data payload
    data = {}
    payload.each do |item|
      data[item.dig(:payload, :Id)] = [] if data[item.dig(:payload, :Id)].blank?
      data[item.dig(:payload, :Id)] << item.dig(:payload)
    end
    data
  end
end
