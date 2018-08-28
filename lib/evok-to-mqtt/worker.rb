require 'eventmachine'
require 'websocket-eventmachine-client'
require 'json'
require 'em/mqtt'

module EvokToMqtt
  class Worker
    def initialize(evok_host, mqtt_host)
      #@evok = ::Faye::WebSocket::Client.new("ws://#{evok_host}:8080/ws")
      @evok_host = evok_host
      #@mqtt = ::MQTT::Client.connect(mqtt_host)
      @mqtt_host = mqtt_host
    end

    def run
      EM.run do
        @evok = WebSocket::EventMachine::Client.connect(:uri => "ws://#{@evok_host}:8080/ws")
        @mqtt = ::EventMachine::MQTT::ClientConnection.connect(@mqtt_host)

        @evok.onmessage do |msg|
          # puts "Recieved message: #{msg}"
          JSON.parse(msg).each do |event|
            puts event
            @mqtt.publish event["circuit"], event
          end
        end

        #@mqtt.subscribe('neuron/#')
        #@mqtt.receive_callback do |topic,message|
        #  puts "################################"
        #  puts topic
        #  puts message
        #end
      end
    end
  end
end
