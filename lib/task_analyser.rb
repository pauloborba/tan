require_relative 'ErbFileAnalyser/Grab_controller_from_erb_file'
require_relative '../lib/HamlFileAnalyser/Grab_controller_from_haml_file'
class TaskAnalyser

  def grab_controllers(file_path)
    extension = get_file_extension(file_path)
    case extension.downcase
      when 'erb'
        puts ControllerGrabber.new.grab_controllers(file_path)
      when 'haml'
        puts Grab_controller_from_haml_file.new.controller_grabber(file_path)
      else

    end
  end

  def get_file_extension(file_path)
    extension_regex = /(?<=\.).*/
    extension = (file_path.scan extension_regex)[0]
    if extension.include?('.')
      extension = extension_regex.match extension
    end
    extension.to_s
  end

end