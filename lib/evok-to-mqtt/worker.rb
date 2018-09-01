require 'eventmachine'
require 'websocket-eventmachine-client'
require 'json'
require 'em/mqtt'
require 'net/http'

module EvokToMqtt
  class Worker
    def initialize(evok_host, mqtt_host, mapper)
      @evok_host = evok_host
      @mqtt_host = mqtt_host
      @mapper    = mapper
    end

    def run
      EM.run do
        @evok = WebSocket::EventMachine::Client.connect(:uri => "ws://#{@evok_host}:8080/ws")
        @mqtt = EventMachine::MQTT::ClientConnection.connect(@mqtt_host)

        @evok.onmessage do |msg|
          JSON.parse(msg).each do |event|
            next if event['dev'] == 'wd'  # skip watchdog events
            puts "Recieved message: #{event}"
            @mapper.process(@mqtt, event)
          end
        end

        @mqtt.subscribe('neuron/output/relay/#')
        @mqtt.receive_callback do |msg|
          # WS set did not work, using REST for now
          data = JSON.parse(msg.payload)
          puts "Sending command #{msg.topic} => #{data['value']}"
          uri = URI("http://#{@evok_host}/rest/#{data['dev']}/#{data['circuit']}")
          Net::HTTP.post_form(uri, 'value' => data['value'])
        end
      end
    end
  end
end
