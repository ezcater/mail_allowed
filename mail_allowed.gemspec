# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mail_allowed/version'

Gem::Specification.new do |spec|
  spec.name          = 'mail_allowed'
  spec.version       = MailAllowed::VERSION
  spec.authors       = ['ezCater Inc']
  spec.email         = ['engineering@ezcater.com']

  spec.summary       = 'Easily specify the allowed email addresses in your Rails app.'
  spec.homepage      = 'https://www.github.com/ezcater/mail_allowed'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
