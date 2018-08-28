
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "evok-to-mqtt/version"

Gem::Specification.new do |spec|
  spec.name          = "evok-to-mqtt"
  spec.version       = EvokToMqtt::VERSION
  spec.authors       = ["Marek Aufart"]
  spec.email         = ["aufi.cz@gmail.com"]

  spec.summary       = %q{A bridge between Unipi's EVOK and MQTT message bus}
  spec.description   = %q{A bridge between Unipi's EVOK and MQTT message bus as Ruby gem}
  spec.homepage      = "https://github.com/aufi/evok-to-mqtt"
  spec.license       = "apache"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "websocket-eventmachine-client"
  spec.add_dependency "em-mqtt"
  #spec.add_dependency "finite_machine"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
