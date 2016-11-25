
class Grab_controller_from_haml_file

  require_relative '../../lib/HamlFileAnalyser/Haml_end_adder'
  require_relative '../../lib/ErbFileAnalyser/find_controller_calls'
  require_relative '../HamlFileAnalyser/haml_parser'
  require_relative '../Util/file_manager'
  require_relative '../Util/output_model'
  require_relative '../../lib/Util/ruby_parser'

  def controller_grabber(file_path)
    output_value = ""
    text = Haml_end_adder.new([]).add_ends(file_path)
    code = Haml_parser.new.parse(text)
    parsed_code = Ruby_parser.new.parse_code(code)
    output_array = Find_controller_calls.new([],"","").find_controllers(parsed_code)
    output_array.each do |output|
      output_value = output_value + "[name: '#{output.name}', receiver: '#{output.receiver}']\n"
    end
    puts output_value
  end
end

Grab_controller_from_haml_file.new.controller_grabber('C:/Users/jpms2/Desktop/tanGem/TAn/samples/sample2.html.haml')