# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'send_and_puff/version'

Gem::Specification.new do |spec|
  spec.name          = "send_and_puff"
  spec.version       = SendAndPuff::VERSION
  spec.authors       = ["Luke Matthew Sutton", "Ben Hull"]
  spec.email         = ["lukeandben@spookandpuff.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = "spookandpuff.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     'httparty',   "~> 0.11.0"
  spec.add_runtime_dependency     'nokogiri',   "~> 1.8.2"
  spec.add_development_dependency "bundler",    "~> 1.3"
  spec.add_development_dependency "yard",       "~> 0.9.11"
  spec.add_development_dependency "rake"
end
