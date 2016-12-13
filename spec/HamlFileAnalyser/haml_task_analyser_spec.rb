require 'rspec'
require_relative '../../lib/HamlFileAnalyser/Grab_controller_from_haml_file'

describe 'Extraction of dependencies in haml files, including calls to controller actions' do

  it 'Does not break for any of the files in the directory' do
    $a = true
    hard_path = __dir__
    i = 0
    error_array = []
    path = (hard_path.scan(/.*(?=\/)/)[0])[0..-6]
    files = Dir["#{path}/**/*.haml"]
    files.each do |file_name|
      begin
        text = Haml_end_adder.new([]).add_ends(file_name)
        code = Haml_parser.new.parse(text)
        parsed_code = Ruby_parser.new.parse_code(code)
        Find_controller_calls.new([],'','','haml').find_controllers(parsed_code)
      rescue
        $a = false
        error_array.push(file_name)
        i += 1
      end
    end
    puts error_array
    puts i
    expect($a).to eq true
  end
end