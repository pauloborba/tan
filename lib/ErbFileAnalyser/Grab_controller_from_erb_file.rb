#Call erb_tags_remover on the input file, then calls ruby_parser to parse the code into ast, calls method_controller_visitor
#to get all calls to possible controllers and output them in a file

class ControllerGrabber

  require_relative '../ErbFileAnalyser/Erb_tags_remover'
  require_relative '../ErbFileAnalyser/find_controller_calls'
  require_relative '../Util/file_manager'
  require_relative '../Util/ruby_parser'
  require_relative '../Util/output_model'
  require 'ast/node'

  def grab_controllers(file_path)
    output_value = ""
    file_manager = File_manager.new
    file_text = file_manager.read_file(file_path)
    code = ErbTagsRemover.new.remove_erb_tags(file_text)
    parsed_code = Ruby_parser.new.parse_code(code)
    output_array = Find_controller_calls.new([],"","").find_controllers(parsed_code)
    output_array.each do |output|
      output_value = output_value + "[name: '#{output.name}', receiver: '#{output.receiver}']\n"
    end
    puts output_value
  end

end

ControllerGrabber.new.grab_controllers 'C:/Users/jpms2/Desktop/tanGem/TAn/samples/sample20.html.erb'