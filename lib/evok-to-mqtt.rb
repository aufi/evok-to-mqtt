require 'evok-to-mqtt/mappers/to_haab'
require 'evok-to-mqtt/version'
require 'evok-to-mqtt/worker'
require 'yaml'

module EvokToMqtt
  def self.run(opts)
    mapping_config = YAML.load(File.read(opts[:config]))
    # TODO: add mapper switch raw/haab/..
    app = EvokToMqtt::Worker.new(opts[:evok_host], opts[:mqtt_host], EvokToMqtt::Mappers::ToHaab.new(mapping_config))
    app.run
  end
end
