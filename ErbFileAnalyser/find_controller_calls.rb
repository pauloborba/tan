#Visits parse tree looking for calls to controllers, when found, insert them on an array
class Find_controller_calls

  require 'ast/node'
  require_relative '../Util/transform_into'

  def initialize(array, instanceVar, localVar)
    $output_array = array
    $instance_variable = instanceVar
    $lvar_derived_from_ivar = localVar
  end

  $link_to = :link_to
  $str = :str
  $ivar = :ivar
  $lvar = :lvar
  $submit = :submit
  $form_for = :form_for
  $each = :each
  $label = :label
  $hash = :hash
  $confirm = :confirm
  $block = :block
  $send = :send

  def find_controllers(code)
    instance_variable = look_for_instance_variable(code)
    lvar_derived_from_ivar = look_for_argument_loop(code)
    code.children.each do |code_children|
      if !(code_children.is_a?(Symbol) || code_children.is_a?(NilClass) || code_children.is_a?(String))
        look_for_link_to_calls(code_children)
        look_for_submit_calls(code_children, instance_variable)
        look_for_auto_gen_methods(code_children,instance_variable,lvar_derived_from_ivar)
        find_controllers(code_children)
      end
    end
    $output_array
  end

  def insert_outputs_on_array(name, receiver)
    output_model = Output_model.new
    output_model.name = name
    output_model.receiver = receiver
    $output_array.push output_model
  end

end

def look_for_link_to_calls(code_children)
  if code_children.children[1] == $link_to && code_children.children[2].type == $str
    found_confirm_call = look_for_confirm_call(code_children)
    if !found_confirm_call
      if code_children.children[3].type == $ivar || code_children.children[3].type == $lvar
       transform_into = Transform_into.new
       insert_outputs_on_array(transform_into.var_into_method(code_children.children[3].children[0]), "")
      else
        if !code_children.children[3].children[1].nil?
          insert_outputs_on_array(code_children.children[3].children[1], "")
        end
      end
    end
  end
end

def look_for_submit_calls(code_children, instance_variable)
  if code_children.children[1] == $submit && code_children.children[2].type == $str
    transform_into = Transform_into.new
    insert_outputs_on_array("#{code_children.children[2].children[0]}".downcase,transform_into.var_into_controller(instance_variable))
  end
end

def look_for_auto_gen_methods(code_children, instance_variable,lvar_derived_from_ivar)
  if code_children.children[1] == $label
    insert_outputs_on_array(code_children.children[2].children[0], instance_variable)
  end
  if !(code_children.children[0].is_a?(Symbol) || code_children.children[0].is_a?(NilClass) || code_children.children[0].is_a?(String))
    if code_children.children[0].type == $lvar && !code_children.children[1].nil?
      if code_children.children[0].children[0] == lvar_derived_from_ivar
        insert_outputs_on_array(code_children.children[1], instance_variable)
      end
    end
  end
end

def look_for_argument_loop(code)
  if $lvar_derived_from_ivar == ""
    code.children.each do |code_children|
      if !(code_children.is_a?(Symbol) || code_children.is_a?(NilClass) || code_children.is_a?(String))
        if code_children.type == $block
          if code_children.children[0].type == $send
            if code_children.children[0].children[1] == $each
              $lvar_derived_from_ivar = code_children.children[1].children[0].children[0]
            end
          end
        end
        look_for_argument_loop(code_children)
      end
    end
  else
    $lvar_derived_from_ivar
  end
  end

def look_for_instance_variable(code)
  if $instance_variable == ""
    code.children.each do |code_children|
      if !(code_children.is_a?(Symbol) || code_children.is_a?(NilClass) || code_children.is_a?(String))
        if code_children.children[1] == $form_for && code_children.children[2].type == $ivar
          $instance_variable = code_children.children[2].children[0]
        elsif  code_children.children[1] == $each
          $instance_variable = code_children.children[0].children[0]
        end
        look_for_instance_variable(code_children)
      end
    end
  else
    Transform_into.new.singular("#{$instance_variable}")
  end
end

def look_for_confirm_call(code_children)
  if !code_children.children[4].nil?
    if code_children.children[4].type == $hash && code_children.children[4].children[0].children[0].children[0] == $confirm
      transform_into = Transform_into.new
      insert_outputs_on_array("#{code_children.children[2].children[0]}".downcase,transform_into.var_into_controller(code_children.children[3].children[0]))
      true
    end
  else
    false
  end
end