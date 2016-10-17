class ControllerGrabber

  require_relative '../ErbFileAnalyser/Erb_tags_remover'
  require_relative '../Visitors/method_controller_visitor'
  require_relative '../Util/file_manager'
  require_relative '../Util/ruby_parser'
  require_relative '../Util/output_model'
  require 'ast/node'

  def grab_controllers(file_path)
    output_value = ""
    file_text = File_manager.new.read_file(file_path)
    code = ErbTagsRemover.new.remove_erb_tags(file_text)
    parsed_code = Ruby_parser.new.parse_code(code)
    output_array = Method_controller_visitor.new.find_controllers(parsed_code)
    output_array.each do |output|
      output_value = output_value + "[name: #{output.name}, type: #{output.type}]\n"
    end
    File_manager.new.write_on_file(output_value, "output")
  end

end