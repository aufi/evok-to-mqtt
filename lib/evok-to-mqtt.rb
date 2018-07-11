# load everything
#Dir['./lib/**/*.rb'].each{ |f| require f }

module EvokToMqtt
  def self.run(evok_host, mqtt_host)
    app = EvokToMqtt::Worker.new(evok_host, mqtt_host)
    app.run
  end
end
