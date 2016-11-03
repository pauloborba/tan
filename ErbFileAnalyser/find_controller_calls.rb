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
    lvar_derived_from_ivar = look_for_loop_argument(code)
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

def look_for_link_to_calls(code)
  method_name = code.children[1]
  if method_name == $link_to
    found_confirm_call = look_for_confirm_call(code)
    if !found_confirm_call
      method_argument_type = code.children[3].type
      if method_argument_type == $ivar || method_argument_type == $lvar
        method_argument_value = code.children[3].children[0]
        insert_outputs_on_array(Transform_into.var_into_method(method_argument_value), "")
      else
        method_inside_link_to_has_params = code.children[3].children[1].nil?
        if !method_inside_link_to_has_params
          method_inside_link_to_param = code.children[3].children[1]
          insert_outputs_on_array(method_inside_link_to_param, "")
        end
      end
    end
  end
end

def look_for_submit_calls(code, instance_variable)
  method_name = code.children[1]
  if method_name == $submit
    method_argument = code.children[2].children[0]
    insert_outputs_on_array("#{method_argument}".downcase,Transform_into.var_into_controller(instance_variable))
  end
end

def look_for_auto_gen_methods(code, instance_variable,lvar_derived_from_ivar)
  method_name = code.children[1]
  if method_name == $label
    method_argument_value = code.children[2].children[0]
    insert_outputs_on_array(method_argument_value, instance_variable)
  end
  if !(code.children[0].is_a?(Symbol) || code.children[0].is_a?(NilClass) || code.children[0].is_a?(String))
    variable_type = code.children[0].type
    variable_calls_method = !code.children[1].nil?
    if variable_type == $lvar && variable_calls_method
      method_argument = code.children[0].children[0]
      if method_argument == lvar_derived_from_ivar
        insert_outputs_on_array(method_name, instance_variable)
      end
    end
  end
end

def look_for_loop_argument(code)
  if $lvar_derived_from_ivar == ""
    code.children.each do |code_children|
      if !(code_children.is_a?(Symbol) || code_children.is_a?(NilClass) || code_children.is_a?(String))
        if code_children.type == $block
          if code_children.children[0].type == $send
            loop_type = code_children.children[0].children[1]
            if loop_type == $each
              loop_argument_variable = code_children.children[1].children[0].children[0]
              $lvar_derived_from_ivar = loop_argument_variable
            end
          end
        end
        look_for_loop_argument(code_children)
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
        loop_type = code_children.children[1]
        if loop_type == $form_for && code_children.children[2].type == $ivar
          loop_variable_value = code_children.children[2].children[0]
          $instance_variable = loop_variable_value
        elsif  loop_type == $each
          loop_variable_value = code_children.children[0].children[0]
          $instance_variable = loop_variable_value
        end
        look_for_instance_variable(code_children)
      end
    end
  else
    Transform_into.singular("#{$instance_variable}")
  end
end

def look_for_confirm_call(code)
  has_aditional_call = !code.children[4].nil?
  if has_aditional_call
    link_to_type = code.children[4].type
    has_confirm_call = code.children[4].children[0].children[0].children[0]
    if link_to_type == $hash && has_confirm_call == $confirm
      link_to_redirect_name = code.children[2].children[0]
      link_to_argument_variable = code.children[3].children[0]
      insert_outputs_on_array("#{link_to_redirect_name}".downcase,Transform_into.var_into_controller(link_to_argument_variable))
      true
    end
  else
    false
  end
end