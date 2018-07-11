require 'websocket-client-simple'

module EvokToMqtt
  class Worker
    def initialize(evok_host, mqtt_host)
      @evok = ::WebSocket::Client::Simple.connect("ws://#{evok_host}:8080/ws")
      @mqtt = ::MQTT::Client.connect(mqtt_host)
    end

    def run
      setup_evok_callbacks
      loop do
        puts "#{Time.now} #{@evok.inspect} #{@mqtt.inspect}"
        sleep 600
      end
    end

    private

    def setup_evok_callbacks
      @evok.on :message do |msg|
       puts Time.now
       p msg
       #@mqtt.publish topic, message, retain
      end
    end
  end
end
