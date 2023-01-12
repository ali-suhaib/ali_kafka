require "#{Rails.root}/lib/dummy.rb"

class SecondConsumer
  include Phobos::Handler

  def self.start(kafka_client)
    # setup handler
    puts "Starting Second Consumer"
  end

  def consume(payload, metadata)
    puts "------------------------"*100
    puts payload
    puts "------------------------"*100

    # payload  - This is the content of your Kafka message, Phobos does not attempt to
    #            parse this content, it is delivered raw to you
    # metadata - A hash with useful information about this event, it contains: The event key,
    #            partition number, offset, retry_count, topic, group_id, and listener_id
  end
end
