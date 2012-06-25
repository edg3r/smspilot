# -*- encoding: utf-8 -*-
require File.expand_path('../lib/smspilot/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rake"]
  gem.email         = ["blazesolo@gmail.com"]
  gem.description   = %q{}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "smspilot"
  gem.require_paths = ["lib"]
  gem.version       = Smspilot::VERSION


  gem.add_runtime_dependency "faraday", '~> 0.8.1'
  gem.add_runtime_dependency "faraday_middleware", '~> 0.8.8'
  gem.add_runtime_dependency 'hashie', '~> 1.2.0'

  gem.add_development_dependency 'rspec', '~> 2.5'
  gem.add_development_dependency 'webmock'



end
