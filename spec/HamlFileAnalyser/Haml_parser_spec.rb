require 'rspec'
require_relative '../../lib/HamlFileAnalyser/Haml_end_adder'
require_relative '../../lib/HamlFileAnalyser/Haml_parser'

describe 'Haml parser function' do

  it 'does not break for the files in the samples directory' do
    $a = true
    hard_path = __dir__
    path = (hard_path.scan(/.*(?=\/)/)[0])[0..-6]
    i = 1
    while i < 9 do
      haml_end_adder = Haml_end_adder.new([])
      unparsed_code = haml_end_adder.add_ends("#{path}/samples/sample#{i}.html.haml")
      i += 1
      begin
        haml_parser = Haml_parser.new
        haml_parser.parse(unparsed_code)
      rescue
        $a = false
      end
    end
    expect($a).to eq true
  end
end