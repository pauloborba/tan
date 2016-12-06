lib = File.expand_path('../lib/', __FILE__)  
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'task_analyser'
  s.version     = '0.0.0.1'
  s.date        = '2016-01-12'
  s.summary     = "task_analyser"
  s.description = "Tool made for finding possible controller calls inside .erb and .haml views"
  s.authors     = ["Joao Pedro de Medeiros Santos"]
  s.email       = 'jpms2@cin.ufpe.br'
  s.files       = Dir.glob("{bin,lib}/**/*")
  s.homepage    = 'http://rubygems.org/gems/task_analyser'
  s.license     = 'MIT'
end