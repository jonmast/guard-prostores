# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/prostores/version'

Gem::Specification.new do |gem|
  gem.name          = "guard-prostores"
  gem.version       = Guard::Prostores::VERSION
  gem.authors       = ["Jonathan Mast"]
  gem.email         = ["jon@padorpers.com"]
  gem.summary       = %q{Guard gem for ProStores}
  gem.description   = %q{Watches for file changes and uploads files to ProStores}
  gem.homepage      = ""
  gem.add_dependency('guard', '>= 1.0')
  gem.add_dependency('httpclient', '~> 2.3')
  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ["lib"]
end
