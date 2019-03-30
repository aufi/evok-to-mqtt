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
            #mqtt.publish id, {action: 'down', data: payload}
          elsif @statuses[id][:value] == 1 && evok_event['value'] == 0
            #mqtt.publish id, {action: 'up', data: payload}
            if now - @statuses[id][:changed_at] < 2  # seconds
              mqtt.publish id, {action: 'click', data: payload}
              puts "### click"
            else
              mqtt.publish id, {action: 'long_click', data: payload}
              puts "### long_click"
            end
          end
          @statuses[id][:value] = evok_event['value']
          @statuses[id][:changed_at] = now
        else
          @statuses[id] = {value: evok_event['value'], changed_at: now}
          #mqtt.publish id, {action: 'down', data: payload} unless evok_event['value'] == 0  # ignore initial states received in batch
        end
        puts
      end

      private

      def get_topic(dev, circuit)
        begin
          return @mapping[dev][circuit] || "evok/#{dev}/#{circuit}" # missing circuit
        rescue => ex
          puts "Warning: #{ex}, using raw topic"
          return "evok/#{dev}/#{circuit}" # missing section (dev)
        end
      end
    end
  end
end
