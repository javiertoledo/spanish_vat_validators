# -*- encoding: utf-8 -*-
require File.expand_path('../lib/spanish_vat_validators/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Javier Toledo"]
  gem.email         = ["javier@theagilemonkeys.com"]
  gem.description   = %q{Provides validators for spanish VAT numbers (NIF, CIF and NIE)}
  gem.summary       = %q{Provides Rails3 compatible validators for spanish VAT numbers (NIF, CIF and NIE), with support for I18n}
  gem.homepage      = "https://github.com/agilemonkeys/spanish_vat_validators"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "spanish_vat_validators"
  gem.require_paths = ["lib"]
  gem.version       = SpanishVatValidators::VERSION
end
