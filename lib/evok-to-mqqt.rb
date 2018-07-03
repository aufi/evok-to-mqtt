# load everything
#Dir['./lib/**/*.rb'].each{ |f| require f }

module EvokToMqtt
  def self.run
    app = EvokToMqtt::Worker.new
    app.run
  end
end
