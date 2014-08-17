# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github_tools/version'

Gem::Specification.new do |spec|
  spec.name          = "github_tools"
  spec.version       = GithubTools::VERSION
  spec.authors       = ["Ivan Tse"]
  spec.email         = ["ivan.tse1@gmail.com"]
  spec.summary       = %q{A collection of GitHub command line commands for a better workflow}
  spec.description   = %q{GithubTools is a command line that bundles a variety of functionality that better integrates GitHub with Git.}
  spec.homepage      = "https://github.com/ivantsepp/github_tools"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency('octokit', "~> 3.0")
  spec.add_runtime_dependency('thor', "~> 0.19")

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
