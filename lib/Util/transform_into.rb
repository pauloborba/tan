require 'active_support/inflector'

class Transform_into

  def self.var_into_controller(var)
    if var == ''

    else
      if var[-1] == 'y'
        var = "#{var[0...-1]}ies_controller"
      else
        var = "#{var}s_controller"
      end
    end
  end

  def self.var_into_method(var)
    if var.to_s[0] == '@'
     "#{(var.to_s)[1..-1]}_path"
    else
      var = "#{var}_path"
    end
  end

  def self.singular(var)
    var.singularize
  end

  def self.name_with_extension(var)
    var = var << '.html.haml'
    if var !~ /\//
      var = '_' << var
    else
      var = var.gsub(/(\/)(?!.*\/)/, "/_");
    end
    var
  end

end