# tan

Tool made for finding possible controller calls inside .erb views.
Ruby version : 2.3.1

Run it by: (don't forget to bundle install!)
  ruby -r "./Grab_controller_from_erb_file.rb" -e "ControllerGrabber.grab_controllers
  'your_directory/you_erb_file_name'"
  or
  gem install 'erb_dependencies'
  
  require_relative 'lib/erb_dependencies'
  
  possible_controller_calls = Erb_dependencies.new.grab_controllers(file_path)
  
Architecture:
  
  [Grab_controller_from_erb_file.rb](https://github.com/jpms2/tan/blob/master/ErbFileAnalyser/Grab_controller_from_erb_file.rb) is the main file, receiving all methods and calling them together to create an output folder on the project directory.
  [Erb_tags_remover.rb](https://github.com/jpms2/tan/blob/master/ErbFileAnalyser/Erb_tags_remover.rb) gets the raw input and finds erb chunks of code, transforming them into pure ruby code
  [method_controller_visitor.rb](https://github.com/jpms2/tan/blob/master/Visitors/method_controller_visitor.rb) walks through the parse tree looking for calls to controller methods, and returns an an output_model array
