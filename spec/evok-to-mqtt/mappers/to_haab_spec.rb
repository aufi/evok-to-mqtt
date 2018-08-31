RSpec.describe EvokToMqtt::Mappers::ToHaab do
  subject { EvokToMqtt::Mappers::ToHaab }

  {"circuit"=>"3_01", "value"=>0, "glob_dev_id"=>1, "dev"=>"wd", "timeout"=>5000, "was_wd_reset"=>0, "nv_save"=>0}
{"counter_modes"=>["Enabled", "Disabled"], "glob_dev_id"=>1, "modes"=>["Simple", "DirectSwitch"], "value"=>1, "circuit"=>"2_14", "debounce"=>50, "counter"=>9, "counter_mode"=>"Enabled", "dev"=>"input", "mode"=>"Simple"}
{"counter_modes"=>["Enabled", "Disabled"], "glob_dev_id"=>1, "modes"=>["Simple", "DirectSwitch"], "value"=>1, "circuit"=>"2_14", "debounce"=>50, "counter"=>10, "counter_mode"=>"Enabled", "dev"=>"input", "mode"=>"Simple"}
{"counter_modes"=>["Enabled", "Disabled"], "glob_dev_id"=>1, "modes"=>["Simple", "DirectSwitch"], "value"=>0, "circuit"=>"2_14", "debounce"=>50, "counter"=>10, "counter_mode"=>"Enabled", "dev"=>"input", "mode"=>"Simple"}

{"glob_dev_id"=>1, "unit"=>"V", "value"=>0.010432695953842653, "circuit"=>"1_01", "range_modes"=>["10.0"], "modes"=>["Voltage", "Current"], "range"=>"10.0", "dev"=>"ai", "mode"=>"Voltage"}


  it "does something useful" do
    expect(false).to eq(true)
    dev, circuit, value
  end
end
