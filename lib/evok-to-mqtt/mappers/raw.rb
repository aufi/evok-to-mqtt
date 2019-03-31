module EvokToMqtt
  module Mappers
    class Raw
      def initialize(mapping)
        @mapping_config  = mapping
      end

      def process(mqtt, evok_event)
        id = get_topic(evok_event["dev"], evok_event["circuit"])
        
        puts "Target topic: #{id}"
        mqtt.publish id, evok_event

        puts
      end

      def circuit_reverse_lookup(full_topic)
        return full_topic.split("/").last
      end

      private

      def get_topic(dev, circuit)
        return "evok/#{dev}/#{circuit}"
      end
    end
  end
end
