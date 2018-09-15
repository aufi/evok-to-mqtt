# load everything
#Dir['./lib/**/*.rb'].each{ |f| require f }
require 'yaml'

module EvokToMqtt
  def self.run(evok_host, mqtt_host, mapping_file_path = 'evok-to-mqtt-mapping.yml')
    mapping_config = YAML.load(File.read(mapping_file_path))
    app = EvokToMqtt::Worker.new(evok_host, mqtt_host, EvokToMqtt::Mappers::ToHaab.new(mapping_config))
    app.run
  end
end
