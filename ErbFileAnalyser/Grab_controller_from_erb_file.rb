
require '../Util/File_reader'
require '../ErbFileAnalyser/Erb_tags_remover'
require '../Util/ruby_parser'
require 'ast/node'

class ControllerGrabber

  def grab_controllers(file_path)
    file_text = FileReader.new.read_file(file_path)
    code = ErbTagsRemover.new.remove_erb_tags(file_text)
    parsed_code = Ruby_parser.new.parse_code(code)
    print parsed_code
  end
end

ControllerGrabber.new.grab_controllers("C:/Users/jpms2/Desktop/TAn/sample.html.erb")