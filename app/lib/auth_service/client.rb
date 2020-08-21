module AuthService
  class Api
    def self.auth(token)
      AuthService::Api.new('auth').call(token)
    end

    attr_accessor :result
    attr_reader :channel, :exchange, :queue_name, :reply_queue, :mutex, :resource

    def initialize(queue_name)
      @channel = RabbitMq.channel
      @exchange = channel.default_exchange
      @queue_name = queue_name
    end

    def call(token)
      payload = { token: token }.to_json
      execute(payload)
    end

    def message_id
      @message_id ||= SecureRandom.uuid
    end

    private 

    def execute(payload)
      create_reply_queue

      exchange.publish(payload.to_s, 
        routing_key: queue_name,
        correlation_id: message_id,
        reply_to: reply_queue.name
      )

      mutex.synchronize { resource.wait(mutex, 1) }

      result
    end

    def create_reply_queue
      @mutex = Mutex.new
      @resource = ConditionVariable.new
      this = self
      @reply_queue = channel.queue('', exclusive: true)

      reply_queue.subscribe do |_delivery_info, properties, payload|
        if properties[:correlation_id] == this.message_id
          this.result = payload
          this.mutex.synchronize { this.resource.signal }
        end
      end
    end
  end
end