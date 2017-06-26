# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fixer_upper/version"

Gem::Specification.new do |spec|
  spec.name = "fixer_upper"
  spec.version = FixerUpper::VERSION
  spec.authors = ["Zach Ahn"]
  spec.email = ["engineering@zachahn.com"]

  spec.summary = "Renovate text"
  spec.description = "Simple interface for template engines"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.1.0"

  spec.add_runtime_dependency "tilt", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "sass"
  spec.add_development_dependency "the_bath_of_zahn"
end
