# SpanishVatValidators

I've adapted the code from the ValidateSpanishVAT plugin from https://github.com/lleirborras/ValidateSpanishVAT to be distributed as a gem for ease of use with Rails 3.

Also added I18n support for error messages, which you can change by adding this to your locale yml:

    es:
      errors:
        messages:
          not_valid_spanish_vat: El número de identificación fiscal no es válido
          not_valid_spanish_id: El NIF/NIE no es válido
          not_valid_nif: El NIF no es válido
          not_valid_cif: El CIF no es válido
          not_valid_nie: El NIE no es válido

## Installation

Add this line to your application's Gemfile:

    gem 'spanish_vat_validators'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spanish_vat_validators

## Usage

Just use any of the following validators.

    # A person id
    class Spaniard < ActiveRecord::Base
      validates :dni, :valid_nif => true
    end

    # A company id
    class Company < ActiveRecord::Base
      validates :cif, :valid_cif => true
    end

    # A foreigner id
    class Alien < ActiveRecord::Base
      validates :nie, :valid_nie => true
    end

    # Any person id
    class Person < ActiveRecord::Base
      validates :any_id, :valid_spanish_id => true
    end

    # Any kind of id is valid
    class SpanishSubject < ActiveRecord::Base
      validates :nif, :valid_spanish_vat => true
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
