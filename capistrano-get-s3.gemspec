# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/get/s3/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-get-s3"
  spec.version       = Capistrano::Get::S3::VERSION
  spec.authors       = ["Lars Fronius"]
  spec.email         = ["l.fronius@googlemail.com"]
  spec.description   = %q{Introduces a new deployment strategy where we pull the codebase as a tar.gz of an s3 bucket}
  spec.summary       = %q{Deploy from S3}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.add_dependency 'capistrano', "< 3.0.0"
  spec.add_dependency 'fog', ">= 1.14.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
