#Visits parse tree looking for calls to controllers, when found, insert them on an array
class Method_controller_visitor

  require 'ast/node'

  def initialize(array)
    $output_array = array
  end

  def find_controllers(code)

    link_to = :link_to
    str = :str
    ivar = :ivar
    code.children.each do |code_children|
      if !(code_children.is_a?(Symbol) || code_children.is_a?(NilClass) || code_children.is_a?(String))
        if code_children.children[1] == link_to && code_children.children[2].type == str
          if code_children.children[3].type == ivar
            insert_outputs_on_array(code_children.children[2].children[0], code_children.children[3].children[0])
          else
            insert_outputs_on_array(code_children.children[2].children[0], code_children.children[3].children[1])
          end
        else
          find_controllers(code_children)
        end
      end
    end
    $output_array
  end

  def insert_outputs_on_array(name, type)
    output_model = Output_model.new
    output_model.name = name
    output_model.type = type
    $output_array.push output_model
  end

end