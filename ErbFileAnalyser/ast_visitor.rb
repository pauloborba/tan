require 'ast'
require 'ast/node'
require './Grab_controller_from_erb_file'

class Ast_visitor < AST::Processor

  def find_controllers(code)
    puts code.class
  end

end

Ast_visitor.new.find_controllers(ControllerGrabber.new.grab_controllers("C:/Users/jpms2/Desktop/TAn/sample.html.erb"))