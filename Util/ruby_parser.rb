require 'parser/current'
require 'ast'

class Ruby_parser
 Parser::Builders::Default.emit_lambda = true # opt-in to most recent AST format

  def parse_code(code)
    parsed = p Parser::CurrentRuby.parse(code).loc
  end
end