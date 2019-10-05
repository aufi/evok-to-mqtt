require 'em/mqtt'
require 'eventmachine'
require 'json'
require 'jsonrpc-client'
require 'net/http'
require 'websocket-eventmachine-client'

module EvokToMqtt
  class Worker
    def initialize(evok_host, mqtt_host, mapper)
      @evok_host = evok_host
      @mqtt_host = mqtt_host
      @mapper    = mapper
    end

    def run
      EM.run do
        @evok_ws  = WebSocket::EventMachine::Client.connect(:uri => "ws://#{@evok_host}:8080/ws")
        @evok_rpc = JSONRPC::Client.new("http://#{@evok_host}/rpc")
        @mqtt     = EventMachine::MQTT::ClientConnection.connect(@mqtt_host)

        @evok_ws.onmessage do |msg|
          data = JSON.parse(msg)
          data = [data] if data.is_a? Hash # temp is not in array in evok messages, but in hash..
          data.each do |event|
            next if !event.is_a?(Hash) || %w(wd ai ao).include?(event['dev']) # want just relay, input and temp, skip the rest for now (better to whitelist)
            puts "#{Time.now} Recieved message: #{event}"
            @mapper.process(@mqtt, event)
          end
        end

        # send commands to relay only for now, maybe do more lightweight not to subscribe to everything
        @mqtt.subscribe('#')
        @mqtt.receive_callback do |msg|
          data = JSON.parse(msg.payload)
          next unless data['action'] == 'cmd'
          circuit = data['circuit'] || @mapper.circuit_reverse_lookup(msg.topic)
          puts "#{Time.now} Sending command #{msg.topic}: #{circuit} => #{data['value']}"
          @evok_rpc.relay_set(circuit, data['value'])
        end
      end
    end
  end
end
