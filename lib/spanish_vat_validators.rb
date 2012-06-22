require "spanish_vat_validators/version"

module ActiveModel::Validations

  module SpanishVatValidatorsHelpers
    def message(kind='vat')
      I18n.translate!("errors.messages.not_valid_#{kind}") rescue 'is invalid'
    end

    # Validates NIF
    def validate_nif(value)
      return false unless value.match(/[0-9]{8}[a-z]/i)
      letters = "TRWAGMYFPDXBNJZSQVHLCKE"
      check = value.slice!(value.length - 1..value.length - 1).upcase
      calculated_letter = letters[value.to_i % 23].chr
      return check === calculated_letter
    end

    # Validates CIF
    def validate_cif(value)
      return false unless value.match(/[a-wyz][0-9]{7}[0-9a-z]/i)
      pares = 0
      impares = 0
      uletra = ["J", "A", "B", "C", "D", "E", "F", "G", "H", "I"]
      texto = value.upcase
      regular = /^[ABCDEFGHKLMNPQRS]\d{7}[0-9,A-J]$/#g);
      if regular.match(value).blank?
        false
      else
        ultima = texto[8,1]

        [1,3,5,7].collect do |cont|
          xxx = (2 * texto[cont,1].to_i).to_s + "0"
          impares += xxx[0,1].to_i + xxx[1,1].to_i
          pares += texto[cont+1,1].to_i
        end

        xxx = (2 * texto[8,1].to_i).to_s + "0"
        impares += xxx[0,1].to_i + xxx[1,1].to_i

        suma = (pares + impares).to_s
        unumero = suma.last.to_i
        unumero = (10 - unumero).to_s
        unumero = 0 if(unumero == 10)

        ((ultima == unumero) || (ultima == uletra[unumero.to_i]))
      end
    end

    # Validates NIE, in fact is a fake, a NIE is really a NIF with first number changed to capital 'X' letter, so we change the first X to a 0 and then try to
    # pass the nif validator
    def validate_nie(value)
      return false unless value.match(/[x][0-9]{7,8}[a-z]/i)
      value[0] = '0'
      value.slice(0) if value.size > 9
      validate_nif(value)
    end
  end

  # Validates any Spanish VAT number
  class ValidSpanishVatValidator < ActiveModel::EachValidator
    include SpanishVatValidatorsHelpers
    def validate_each(record, attribute, value)
      record.errors[attribute] = message unless validate_nif(value.clone) or validate_cif(value.clone) or validate_nie(value.clone)
    end
  end

  # Validates NIF number only
  class ValidNifValidator < ActiveModel::EachValidator
    include SpanishVatValidatorsHelpers
    def validate_each(record, attribute,value)
      record.errors[attribute] = message('nif') unless validate_nif(value.clone)
    end
  end

  # Validates CIF number only
  class ValidCifValidator < ActiveModel::EachValidator
    include SpanishVatValidatorsHelpers
    def validate_each(record, attribute,value)
      record.errors[attribute] = message('cif') unless validate_cif(value.clone)
    end
  end

  # Validates NIE number only
  class ValidNieValidator < ActiveModel::EachValidator
    include SpanishVatValidatorsHelpers
    def validate_each(record, attribute,value)
      record.errors[attribute] = message('nie') unless validate_cif(value.clone)
    end
  end

end