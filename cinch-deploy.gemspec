Gem::Specification.new do |s|
  s.name        = 'cinch-deploy'
  s.version     = '1.0.0'
  s.license     = 'Apache 2.0'
  s.summary     =
  s.description = 'A Cinch plugin to start deploy process via irc messages.'
  s.authors     = ['Michal Papis']
  s.email       = ['mpapis@gmail.com']
  s.homepage    = 'https://github.com/mpapis/cinch-deploy'
  s.files       = Dir['LICENSE', 'README.md', 'lib/**/*']
  s.required_ruby_version = '>= 1.9.1'
  s.add_dependency("cinch", "~> 2")
end
