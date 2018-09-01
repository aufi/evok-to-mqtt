RSpec.describe EvokToMqtt::Mappers::ToHaab do
  let(:evok) { double }
  let(:mqtt) { double }

  # inputs
  # {"circuit"=>"3_01", "value"=>0, "glob_dev_id"=>1, "dev"=>"wd", "timeout"=>5000, "was_wd_reset"=>0, "nv_save"=>0}
  # {"counter_modes"=>["Enabled", "Disabled"], "glob_dev_id"=>1, "modes"=>["Simple", "DirectSwitch"], "value"=>1, "circuit"=>"2_14", "debounce"=>50, "counter"=>9, "counter_mode"=>"Enabled", "dev"=>"input", "mode"=>"Simple"}
  # {"counter_modes"=>["Enabled", "Disabled"], "glob_dev_id"=>1, "modes"=>["Simple", "DirectSwitch"], "value"=>1, "circuit"=>"2_14", "debounce"=>50, "counter"=>10, "counter_mode"=>"Enabled", "dev"=>"input", "mode"=>"Simple"}
  # {"counter_modes"=>["Enabled", "Disabled"], "glob_dev_id"=>1, "modes"=>["Simple", "DirectSwitch"], "value"=>0, "circuit"=>"2_14", "debounce"=>50, "counter"=>10, "counter_mode"=>"Enabled", "dev"=>"input", "mode"=>"Simple"}
  # {"glob_dev_id"=>1, "unit"=>"V", "value"=>0.010432695953842653, "circuit"=>"1_01", "range_modes"=>["10.0"], "modes"=>["Voltage", "Current"], "range"=>"10.0", "dev"=>"ai", "mode"=>"Voltage"}

  describe 'events from evok' do
    it 'handles switch down action' do
      event = {"counter_modes"=>["Enabled", "Disabled"], "glob_dev_id"=>1, "modes"=>["Simple", "DirectSwitch"], "value"=>1, "circuit"=>"2_14", "debounce"=>50, "counter"=>9, "counter_mode"=>"Enabled", "dev"=>"input", "mode"=>"Simple"}
      expect(mqtt).to receive(:publish).with("neuron/input/2_14", {:action=>"down", :data => event})
      subject.process(mqtt, event)
    end
  end

  describe 'commands to evok' do
    it 'handles set relay on command' do
      msg = {value: 1}
      expect(evok).to receive(:send).with('{"cmd":"set","dev":"relay","circuit":"1_3","value":"1"}')
      subject.pass_command(evok, msg)
    end
  end
end
