require_relative 'ErbFileAnalyser/Grab_controller_from_erb_file'
class Erb_dependencies

  def self.grab_controllers(file_path)
    ControllerGrabber.new.grab_controllers(file_path)
  end

end

Erb_dependencies.grab_controllers('C:\Users\jpms2\Desktop\tanGem\TAn\samples\sample1.html.erb')