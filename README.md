# tan

Tool made for finding possible controller calls inside .erb and .haml views.
Ruby version : 2.3.1

Run it by: (don't forget to bundle install!)
  ruby -r "./task_analyser.rb" -e "TaskAnalyser.grab_controllers 'your_directory/you_erb_file_name'"
  or
  gem install 'task_analyser'
  
  require_relative 'lib/task_analyser'
  
  possible_controller_calls = task_analyser.new.grab_controllers(file_path)
  
Architecture:
  
  [task_analyser.rb](https://github.com/jpms2/tan/blob/development/lib/task_analyser.rb)is the main file, depending on the extension it decides which class will be used, Haml_controller_extractor or Erb_controller_extractor.
  [find_controller_calls.rb](https://github.com/jpms2/tan/tree/development/lib/Analyser) walks through the parse tree looking for calls to controller methods, and returns a string array with all the information it gets
