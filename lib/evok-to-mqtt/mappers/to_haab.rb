module EvokToMqtt
  module Mappers
    class ToHaab
      def initialize(mapping)
        @mapping  = mapping
        @statuses = {}
      end

      def process(mqtt, evok_event)
        id      = get_topic(evok_event["dev"], evok_event["circuit"])
        now     = Time.now
        payload = evok_event

        puts "Target topic: #{id}"

        # Neuron input is assumed for now
        if @statuses[id]
          if @statuses[id][:value] == 0 && evok_event['value'] == 1
            mqtt.publish id, {action: 'down', data: payload}
          elsif @statuses[id][:value] == 1 && evok_event['value'] == 0
            mqtt.publish id, {action: 'up', data: payload}
            mqtt.publish id, {action: 'click', data: payload} if now - @statuses[id][:changed_at] < 2  # seconds
            # ignore events not changing value
          end
          @statuses[id][:value] = evok_event['value']
          @statuses[id][:changed_at] = now
        else
          @statuses[id] = {value: evok_event['value'], changed_at: now}
          mqtt.publish id, {action: 'down', data: payload}
        end
      end

      private

      def get_topic(dev, circuit)
        begin
          return @mapping[dev][circuit] || "evok_raw/#{dev}/#{circuit}" # missing circuit
        rescue => ex
          puts "Warning: #{ex}, using raw topic"
          return "evok_raw/#{dev}/#{circuit}" # missing section (dev)
        end
      end
    end
  end
end
