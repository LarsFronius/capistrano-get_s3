# coding: utf-8
require File.expand_path('../lib/capistrano-get_s3/version', __FILE__)


Gem::Specification.new do |spec|
  spec.name          = "capistrano-get_s3"
  spec.version       = Capistrano::Get_S3::VERSION
  spec.authors       = ["Lars Fronius"]
  spec.email         = ["l.fronius@googlemail.com"]
  spec.description   = %q{Introduces a new deployment strategy where we pull the codebase as a tar.gz of an s3 bucket}
  spec.summary       = %q{Deploy from S3}
  spec.homepage      = "http://github.com/LarsFronius/capistrano-get_s3"
  spec.license       = "MIT"
  spec.add_dependency 'capistrano', "< 3.0.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
