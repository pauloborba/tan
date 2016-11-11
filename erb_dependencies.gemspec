lib = File.expand_path('../lib/', __FILE__)  
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'erb_dependencies'
  s.version     = '0.0.2.2'
  s.date        = '2016-11-11'
  s.summary     = "erb_dependencies"
  s.description = "Tool made for finding possible controller calls inside .erb views"
  s.authors     = ["Joao Pedro de Medeiros Santos"]
  s.email       = 'jpms2@cin.ufpe.br'
  s.files       = Dir.glob("{bin,lib}/**/*")
  s.homepage    = 'http://rubygems.org/gems/erb_dependencies'
  s.license     = 'MIT'
end