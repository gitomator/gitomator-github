# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitomator/github/version'

Gem::Specification.new do |spec|
  spec.name          = "gitomator-github"
  spec.version       = Gitomator::Github::VERSION
  spec.authors       = ["Joey Freund"]
  spec.email         = ["joeyfreund@gmail.com"]

  spec.summary       = %q{Gitomator GitHub provider}
  spec.description   = %q{Automate the management of GitHub organizations}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency 'octokit', '~> 4.2'
end
