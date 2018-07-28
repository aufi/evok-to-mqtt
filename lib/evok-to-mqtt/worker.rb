require 'eventmachine'
require 'faye/websocket'
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
        @evok = ::Faye::WebSocket::Client.new("ws://#{@evok_host}:8080/ws")

        @evok.on :message do |msg|
         puts Time.now
         JSON.parse(msg.data).each do |event|
           puts event
           @mqtt.publish event["circuit"], event
         end
        end

        #@mqtt = ::MQTT::Client.connect(@mqtt_host)
        @mqtt = ::EventMachine::MQTT::ClientConnection.connect(@mqtt_host)

        @mqtt.subscribe('neuron/#')
        #@mqtt.get do |topic,message|
        #  puts "################################"
        #  puts topic
        #  puts message
        #end
        @mqtt.receive_callback do |message|
          p message.methods
        end

      end
    end
  end
end
