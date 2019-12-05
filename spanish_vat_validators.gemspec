# -*- encoding: utf-8 -*-
require File.expand_path('../lib/spanish_vat_validators/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Gil", "Javier Toledo"]
  gem.email         = ["javier@theagilemonkeys.com"]
  gem.description   = %q{Provides validators for spanish VAT numbers (NIF, CIF and NIE)}
  gem.summary       = %q{Provides Rails3+ compatible validators for spanish VAT numbers (NIF, CIF and NIE), with support for I18n}
  gem.homepage      = "https://github.com/agilemonkeys/spanish_vat_validators"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "spanish_vat_validators"
  gem.require_paths = ["lib"]
  gem.version       = SpanishVatValidators::VERSION

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency 'activemodel', '>= 3.2.0'

  gem.add_development_dependency 'bundler', '~> 1.6'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'appraisal'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'codeclimate-test-reporter', '~> 1.0.0'
end
